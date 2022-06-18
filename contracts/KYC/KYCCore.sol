pragma solidity ^0.8.0;

import "./OrgRegistry.sol";

import "./IDRegistry.sol";

import "./KYCToken.sol";

contract KYCCore {

    address private kycGov;

    OrgRegistry private OrgR;

    IDRegistry private IDR;

    KYCToken private KYCT;

    uint256 public Rate;

    modifier isGov( ){
        require( msg.sender == kycGov," Error not KYC Gov");
        _;
    }

    modifier isValidAddRec(bytes32 _hash , uint8 _type ) {
        IDRegistry.userStruct memory Usr = IDR.fetchUserData(_hash , _type);
        require(Usr.status == false ," ID already there");
        _;
    }

    modifier isValidPurchase(bytes32 _hash ) {
        require(IDR.fetchHasaccess(_hash, msg.sender) == true ,"Already has access");
        _;
    }

    modifier isValidView(bytes32 _hash ) {
        require(IDR.fetchHasaccess(_hash,msg.sender) == true ,"Already has access");
        _;
    }

    modifier isValidOrg() {
        require(OrgR.fetchOrg(msg.sender) == true ," Org Is invalid");
        _;
    }

    constructor ( address _kycGov  ) {
        kycGov = _kycGov;
    }

    function SetRate( uint256 _rate ) external isGov{
        Rate = _rate;
    }

    function SetOrgRegistry( address _orgR ) external isGov{
        OrgR = OrgRegistry(_orgR);
    }

    function SetIDRegistry( address _orgR ) external isGov{
        IDR = IDRegistry(_orgR);
    }

    function SetToken( address _token ) external isGov{
        KYCT = KYCToken(_token);
    }

    function addRecord(bytes32 _hash , uint8 _type ) external isValidOrg isValidAddRec(_hash , _type) {
        IDR.SetKYC(_hash , _type , msg.sender);
    }

    function purchaseRecord(bytes32 _hash , uint8 _type ) external isValidOrg isValidPurchase( _hash ) {
        IDRegistry.userStruct memory Usr = IDR.fetchUserData(_hash , _type);
        KYCT.transferFrom( msg.sender , Usr._verifier , Rate);
        IDR.SetAccess(_hash , msg.sender);
    }

    function viewRecord(bytes32 _hash , uint8 _type) external isValidOrg isValidView( _hash ) view returns (IDRegistry.userStruct memory ){
        IDRegistry.userStruct memory Usr = IDR.fetchUserData(_hash , _type);
        return Usr;
    }

}
