// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

abstract contract BaseContract {

    struct contractStruct{
        uint256 val1;
    }

    mapping ( uint256 => contractStruct ) public map3;

    function setFunctionA(
        uint256 _a,
        bool _b,
        uint256 _c
    ) internal  returns( bool ){
        if ( _b == true ){
            map3[_a].val1 = _c * _c;
        }else{
            map3[_a].val1 = _c + 2;
        }
        return true;
    }

    function setFunctionB(
        uint256 _a,
        bool _b,
        uint256 _c
    ) private returns( bool ){
        if ( _b == true ){
            map3[_a].val1 = _c * _c;
        }else{
            map3[_a].val1 = _c + 2;
        }
        return true;
    }

    function setBA( uint256 _a , uint256 _b ) internal {
        setFunctionB( _a , true , _b );
    }

    function setBB( uint256 _a , uint256 _b ) internal {
        setFunctionB( _a , false , _b );
    }

}
