// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ERC20Token_Voting is ERC20 {
    using SafeMath for uint256;

    constructor(string memory name_, string memory symbol_ , uint256 _mintAmt , address _custodial )  ERC20(name_, symbol_) {
        _mint(_custodial,_mintAmt);
    }

}
