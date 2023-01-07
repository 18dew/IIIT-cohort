// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingUtils {

    address private Governance;

    address private deployer;

    bool private active;

    modifier isDeployer(){
        require(msg.sender == deployer, "Sentry: Sender is not deployer");
        _;
    }

    modifier isInActive(){
        require(active == false, "Sentry: contract is active");
        _;
    }

    modifier isActive(){
        require(active == true, "Sentry: contract is not active");
        _;
    }

    modifier isGov() {
        require( msg.sender == Governance , "Sentry: Invalid Governance Address");
        _;
    }

    constructor ( ) {
        deployer = msg.sender;
        active = false;
    }

    function activate( address _Governance ) internal isDeployer isInActive {
        deployer = address(0);
        Governance = _Governance;
        active = true;
    }

    function fetchGovernance( ) external view returns ( address ) {
        return Governance;
    }

    function fetchDeployer( ) external view returns ( address ) {
        return deployer;
    }

    function fetchActive( ) external view returns ( bool ) {
        return active;
    }

    function setGovernance( address _governance ) external isGov isActive {
        require( Governance != address(this) , "Sentry : Cant Governance of MetaDAOCouncil");
        Governance = _governance;
    }

}
