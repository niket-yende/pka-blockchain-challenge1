// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {Voting} from "../src/Voting.sol";
import "forge-std/console.sol";

contract VotingTest is Test {
    Voting public voting;

    function setUp() public {
        voting = new Voting();
    }

    function test_ProposeItem() public {
        // Propose some items
        voting.proposeItem("Banana");
        voting.proposeItem("Coffee");
        voting.proposeItem("Tea");
        voting.proposeItem("Beer");
        voting.proposeItem("Water");

        assertEq(voting.itemId(), 5);
    }
}
