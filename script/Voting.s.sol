// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script, console2} from "forge-std/Script.sol";
import {Voting} from "../src/Voting.sol";
import "forge-std/console.sol";

contract VotingScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        // Deploy voting contract
        Voting voting = new Voting();
        console.log('Deployed Voting address: ', address(voting));
    }
}
