pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";
import "./NFTContract_Auction.sol";
import "./ERC20Token_Auction.sol";

contract Auction is AccessControl {

    NFTContract_Auction public NFT;

    ERC20Token_Auction public ERC;

    uint256 public tickCount;

    enum State { InActive , Active , Cancelled , Completed  }

    mapping ( uint256 => AuctionStruct ) public Auctions;

    struct AuctionStruct{
        address Owner;
        uint256 startRate;
        uint256 currentRate;
        uint256 minIncrements;
        uint256 startBlock;
        address currentWinner;
        address endBlock;
        address[] bidders;
        uint256[] bidAmt;
        State AuctionState;
    }

    event ProductAdded ( uint256 _id , uint256 _startRate , uint256 _startBlock );

    event BitEvent ( uint256 _id , uint256 _amt );

    event WinnerClaim ( uint256 _id , uint256 _amt );

    event BidderClaim ( uint256 _id , uint256 _amt , uint256 _index );

    constructor(address _NFT , address _ERC) AccessControl(){
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        NFT = NFTContract_Auction(_NFT);
        ERC = ERC20Token_Auction(_ERC);
    }

    function setTick ( uint256 _tick ) onlyRole(DEFAULT_ADMIN_ROLE) external {
        tickCount = _tick;
    }

    function AddForAuction( uint256 id , uint256 _startBlock , uint256 _startRate , uint256 _minIncrements) external {
        NFT.transferFrom( msg.sender , address(this) , id);
        Auctions[id].Owner = msg.sender;
        Auctions[id].startRate = _startRate;
        Auctions[id].currentRate = _startRate;
        Auctions[id].minIncrements = _minIncrements;
        Auctions[id].startBlock = _startBlock;
        Auctions[id].currentWinner = address(0);
        Auctions[id].endBlock = _startBlock + tickCount;
        Auctions[id].AuctionState = State.Active;
        emit ProductAdded( _id , _startRate , _startBlock );
    }

    function Bid( uint256 id , uint256 _amt ) external {
        require( Auctions[id].minIncrements < _amt , "Bid Amount Less than increments");
        require( Auctions[id].startBlock <= block.number ," Auction not started");
        require( Auctions[id].endBlock >= block.number ," Auction ended");
        require( Auctions[id].AuctionState == State.Active ," Auction Not Active");
        uint256 currentRate = Auctions[id].currentRate;
        Auctions[id].currentRate = currentRate + _amt;
        Auctions[id].currentWinner = msg.sender;
        Auctions[id].endBlock = block.number + tickCount;
        Auctions[id].bidders.push(msg.sender);
        Auctions[id].bidAmt.push(_amt);
        emit BitEvent( id , _amt);
    }

    function Claim( uint256 _id )external {
        require( Auctions[_id].endBlock + tickCount < block.number  ,"Winner Cant Claim" );
        require( Auctions[_id].currentWinner == msg.sender ,"Only winner can " );
        ERC.transferFrom(msg.sender, Auctions[_id].Owner , Auctions[_id].currentRate );
        Auctions[_id].AuctionState = State.Completed;
        NFT.transferFrom(address(this), msg.sender , _id);
        emit WinnerClaim( _id ,Auctions[_id].currentRate );
    }

    function ClaimExpired( uint256 _id , uint256 _index )external {
        require( Auctions[_id].endBlock + tickCount > block.number  ,"Winner Cant Claim" );
        require( Auctions[_id].currentWinner != msg.sender ,"Only winner can " );
        require( Auctions[_id].bidder[_index] == msg.sender ,"Not A Valid bidder");
        uint256 totalBids = Auctions[_id].bidders.length;
        uint256 bIndex = totalBids + 1 - _index;
        require ( Auctions[_id].endBlock + ( bIndex * tickCoin ) < block.number ,"Bidder Cant Claim" );
        ERC.transferFrom(msg.sender, Auctions[_id].Owner , Auctions[_id].bidAmt[_index] );
        Auctions[_id].AuctionState = State.Completed;
        NFT.transferFrom(address(this), msg.sender , _id);
        emit BidderClaim( _id ,Auctions[_id].bidAmt[_index] , _index );
    }

    function CancelAcution( uint256 _id ) external {
        require( Auctions[_id].Owner == msg.sender ," ONly owner ");
        Auctions[_id].AuctionState = State.Cancelled;
        NFT.transferFrom(address(this), msg.sender , _id);
    }


}
