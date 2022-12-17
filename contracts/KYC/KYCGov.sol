// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./OrgRegistry.sol";

import "./IDRegistry.sol";

contract KYCGov is Ownable {

    OrgRegistry OrgR;

    IDRegistry IDR;

    constructor ( ) Ownable(){}

    function SetOrgRegistry( address _orgR ) external onlyOwner{
        OrgR = OrgRegistry(_orgR);
    }

    function SetIDRegistry( address _orgR ) external onlyOwner{
        IDR = IDRegistry(_orgR);
    }

    function setOrg( address _org ) external onlyOwner {
        OrgR.setOrg(_org);
    }

    function unsetOrg( address _org ) external onlyOwner {
        OrgR.unsetOrg(_org);
    }

    function SetType( uint8 _type, string memory _data ) external onlyOwner {
        IDR.SetType(_type , _data);
    }

}
