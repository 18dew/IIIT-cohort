pragma solidity ^0.8.0;

import "./ERC20Token.sol";
import "./NFTContract.sol";

contract NFTFrax {

    NFTContract public NFTC;

    constructor(address _NFTContract){
        NFTC = NFTContract(_NFTContract);
    }

    function fractionliseNFT( uint256 _id , string memory _name, string memory _symbol , uint256 _token ) external {
        ERCNew = new ERC20Token(_name , _symbol , _token * 10 ** 18 , msg.sender );
        NFTC.transferFrom(msg.sender , address(ERCNew) , _id);
    }

}
