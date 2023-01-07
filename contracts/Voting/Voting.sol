// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./ERC20Token_Voting.sol";
import "./VotingUtils.sol";

contract Voting is VotingUtils {
    using SafeMath for uint256;

    ERC20Token_Voting private MDT;

    uint256 private minHolding;

    uint256 private voteDuration;

    enum ProposalStatus { Inactive, Active, Passed, Executed, Cancelled }

    enum VoteStatus { Abstain, Yes, No }

    uint256 private quorum; // Quorum in percentage of total voted population and 1000000 as 100%

    uint256 private proposalCounter;

    mapping ( uint256 => proposalStruct ) private proposals;

    struct proposalStruct{
        address[] to; // Proposal Action
        bytes[] data; // Proposal Action
        uint256 totalVotes;
        uint256 Yes;
        uint256 No;
        uint256 StartBlock;
        ProposalStatus status;
    }

    mapping ( uint256 => mapping ( uint256 => returnStruct ) ) private proposalReturns;

    struct returnStruct{
        bool status;
        bytes returnValue;
    }

    modifier isValidHolding( ){
        require(MDT.balanceOf(msg.sender) >= minHolding , "Voting : Not enough tokens to raise proposal");
        _;
    }

    modifier isActiveProposal( uint256 _proposal ){
        require(proposals[_proposal].StartBlock+voteDuration <= block.number , "Voting : Voting time passed");
        require(MDT.balanceOf(msg.sender) >= 0 , "Voting : Not enough balance for voting");
        _;
    }

    modifier isValidUpdate( uint256 _proposal ){
        require(proposals[_proposal].StartBlock+voteDuration >= block.number , "Voting : Voting time still active");
        require(proposals[_proposal].status == ProposalStatus.Active , "Voting : Proposal must be active");
        _;
    }

    modifier isValidExecute( uint256 _proposal ){
        require(proposals[_proposal].status == ProposalStatus.Passed , "Voting : Proposal must be Passed");
        _;
    }

    constructor( address _parent ) VotingUtils() {
        MDT = ERC20Token_Voting(_parent);
        quorum = 100000;
        voteDuration = 100;
    }

    function activation( address _gov ) external {
        activate(_gov);
    }

    // TODO - Add Proposal Cost
    function initProposal( address[] memory _to , bytes[] memory _data ) external isValidHolding {
        require(_to.length == _data.length ,"Voting : Array Length mismatch");
        proposalCounter = proposalCounter + 1;
        proposals[proposalCounter] = proposalStruct(_to ,  _data , 0 ,0 ,0 ,block.number ,ProposalStatus.Active);
    }

    function CastVote( uint256 _proposal , VoteStatus v1) external isActiveProposal(_proposal) {
        uint256 bal = MDT.balanceOf(msg.sender);
        proposals[_proposal].totalVotes = proposals[_proposal].totalVotes + bal;
        if (v1 == VoteStatus.Yes ){
            proposals[_proposal].Yes = proposals[_proposal].Yes + bal;
        }else if ( v1 == VoteStatus.No ){
            proposals[_proposal].No = proposals[_proposal].No + bal;
        }
    }

    function updateProposal( uint256 _proposal ) external  isValidUpdate(_proposal) {
        bool result = isPassed(_proposal);
        if( result == true ){
            proposals[_proposal].status = ProposalStatus.Passed;
        }else{
            proposals[_proposal].status = ProposalStatus.Cancelled;
        }
    }

    function isPassed( uint256 _proposal ) internal view returns( bool ){
        uint256 totalVotes = proposals[_proposal].totalVotes;
        uint256 totalYes = proposals[_proposal].Yes;
        uint256 percent = ( ( totalYes * 1000000 ) / totalVotes );
        if ( percent > quorum) {
            return true;
        }else{
            return false;
        }
    }

    function executeProposal( uint256 _proposal ) external isValidExecute(_proposal) {
        uint256 length = proposals[_proposal].to.length;
        for ( uint256 i = 0; i < length; i = i+1 ) {
            address caller = proposals[_proposal].to[i];
            ( bool _success , bytes memory _return ) = caller.call( proposals[_proposal].data[i] );
            proposalReturns[_proposal][i] = returnStruct( _success , _return );
        }
        proposals[_proposal].status = ProposalStatus.Executed;
    }

    function setMinHolding( uint256 _holding ) external isGov {
        minHolding = _holding;
    }

    function setVoteDuration( uint256 _duration ) external isGov {
        voteDuration = _duration;
    }

    function setQuorum( uint256 _quorum ) external isGov {
        quorum = _quorum;
    }

    function fetchProposal( uint256 _proposal ) external view returns ( proposalStruct memory ){
        return proposals[_proposal];
    }

    function fetchMetaDaoToken() external view returns ( iKarmToken  ){
        return MDT;
    }

    function fetchMinHolding() external view returns ( uint256 ){
        return minHolding;
    }

    function fetchVoteDuration() external view returns ( uint256 ){
        return voteDuration;
    }

    function fetchQuorum() external view returns ( uint256 ){
        return quorum;
    }

    function fetchProposalCounter() external view returns ( uint256 ){
        return proposalCounter;
    }

}
