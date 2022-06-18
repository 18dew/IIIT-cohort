pragma solidity ^0.8.0;

contract IDRegistry {

    address private kycGov;

    address private kycCore;

    mapping ( bytes32 => mapping ( uint8 => userStruct ) ) private userData; // Hash of ID no -> id type( Aaddhar / passort / pancard etc ) ->

    struct userStruct {
        address _verifier;
        uint256 _time;
        bool status;
    }

    mapping( bytes32 => mapping ( address => bool )) private hasAccess;

    mapping ( uint8 => string ) private idTypeData;

    modifier isGov( ){
        require( msg.sender == kycGov," Error not KYC Gov");
        _;
    }

    modifier isCore( ){
        require( msg.sender == kycCore ," Error not KYC Core");
        _;
    }

    constructor ( address _kycGov , address _kycCore ) {
        kycGov = _kycGov;
        kycCore = _kycCore;
    }

    function SetType( uint8 _type, string memory _data ) external isGov {
        idTypeData[_type] = _data;
    }

    function SetKYC( bytes32 _hash , uint8 _id , address _veri ) external isCore {
        userData[_hash][_id] = userStruct( _veri , block.timestamp , true);
    }

    function SetAccess( bytes32 _hash , address _veri ) external isCore {
        hasAccess[_hash][_veri] = true;
    }

    function fetchUserData( bytes32 _hash , uint8 _type ) external view returns ( userStruct memory ){
        return userData[_hash][_type];
    }

    function fetchHasaccess( bytes32 _hash , address _addr ) external view returns ( bool ){
        return hasAccess[_hash][_addr];
    }

    function fetchType( uint8 _type ) external view returns ( string memory ){
        return idTypeData[_type];
    }

}
