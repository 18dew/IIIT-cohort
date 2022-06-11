// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./iBaseContract.sol";

interface iMainContract is iBaseContract {

    function setA( uint256 _a , uint256 _b ) external;


    function callAny (address addr , bytes4 _selector  , uint256 _a , uint256 _b ) external returns( bool );

}