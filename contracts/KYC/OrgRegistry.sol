pragma solidity ^0.8.0;

//Registered Banks / Org
contract OrgRegistry {

    address private kycGov;

    mapping ( address => bool ) private Orgs;

    modifier isGov( ){
        require( msg.sender == kycGov," Error not KYC Gov");
        _;
    }

    constructor ( address _kycGov ) {
        kycGov = _kycGov;
    }

    function setOrg( address _orgAddr) external isGov{
        Orgs[_orgAddr] = true;
    }

    function unsetOrg( address _orgAddr) external isGov{
        Orgs[_orgAddr] = false;
    }

    function fetchOrg( address _orgAddr) external view returns ( bool ){
        return Orgs[_orgAddr];
    }

}
