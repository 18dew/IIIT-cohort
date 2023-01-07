pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

import "./ERC20Token.sol";

contract ERC20_Sale is AccessControl {

    ERC20Token ERC;

    uint256 rate;

    address benificiary;

    uint256 ctr;

    constructor( address _erc20 , uint256 _rate , address _benificiary ) AccessControl() {
        ERC = ERC20Token(_erc20);
        rate = _rate;
        benificiary = _benificiary;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    // Admin Setters
    function setRate( uint256 _rate ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        rate = _rate;
    }

    function setbenificiary( address _benificiary ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        benificiary = _benificiary;
    }
    // Admin Setters

    // Fetchers
    function getRate( ) external view returns ( uint256 ){
        return rate;
    }

    function getERC( ) external view returns ( address ){
        return address(ERC);
    }

    function getBenificiary( ) external view returns ( address ){
        return benificiary;
    }

    function calculateRate( uint256 _amt ) external view returns ( uint256 ){
        return icalculateRate( _amt );
    }

    // Fetchers

    // Internals
    function icalculateRate( uint256 _amt ) internal view returns ( uint256 ){
        return rate * _amt * ctr;
    }
    // Internals

    // Core

    function purchase ( uint256 _amt ) payable external {
        uint256 value = icalculateRate( _amt );
        require(msg.value >= value , " Insufficient value ");
        uint256 refund = msg.value - value;
        payable(msg.sender).transfer(refund);
        payable(benificiary).transfer(value);
        ERC.transferFrom(benificiary , msg.sender , _amt);
        ctr = ctr + 1 ;
    }
    // Core
}
