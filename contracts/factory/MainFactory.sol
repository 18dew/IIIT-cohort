// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../core/MainContract.sol";

contract MainFactory{

    uint256 public ctr = 0;

    mapping ( uint256 => address ) public MainAddr;

    function createMain ( ) external {
        ctr = ctr + 1;
        MainContract M1 = new MainContract( );
        MainAddr[ctr] = address(M1);
    }

}

