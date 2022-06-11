// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../interfaces/iMainContract.sol";

contract InteractMain1 {

    iMainContract public M1;

    constructor ( address _addr ){
        M1 = iMainContract(_addr);
    }

    function set( uint256 _a , uint256 _b ) external {
        M1.setA(_a, _b );
    }

    function read( uint256 _a ) external view returns ( uint256 _b ){
        return M1.map3(_a).val1;
    }

}
