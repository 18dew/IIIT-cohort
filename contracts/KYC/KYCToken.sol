pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract KYCToken is ERC20 {

    constructor ( uint256 _amount ) ERC20( "KYC Token ", "KYT") {
        _mint(msg.sender, _amount );
    }

}
