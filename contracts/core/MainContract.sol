// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./BaseContract.sol";

contract MainContract is BaseContract {

    // bytes4( keccak256 ( setA(uint256 ,uint256 ) )

    //0x7aa9a3d5
    function setA( uint256 _a , uint256 _b ) external {
        setFunctionA( _a , true , _b );
    }

    //0xf3180546
    function setB( uint256 _a , uint256 _b ) external {
        setFunctionA( _a , false , _b );
    }


    function callAny (address addr , bytes4 _selector  , uint256 _a , uint256 _b ) external returns( bool ) {
        ( bool success , ) = addr.call(
            abi.encodeWithSelector(
                _selector,
                _a,
                _b
            )
        );
        return success;
    }

}