// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script, console2} from "forge-std/Script.sol";
// import {Voting} from "../src/voting.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        // Deploy voting contract
        // Voting voting = new Voting();
    }
}
