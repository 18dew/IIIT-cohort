// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

interface iBaseContract {

    struct contractStruct{
        uint256 val1;
    }

    function map3(uint256 ) external view returns( contractStruct memory );

}