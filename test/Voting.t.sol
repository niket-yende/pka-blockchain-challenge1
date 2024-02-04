// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {Voting} from "../src/Voting.sol";
import "forge-std/console.sol";

contract VotingTest is Test {
    Voting public voting;
    address userOne = address(1);
    address userTwo = address(2);
    address userThree = address(3);
    address userFour = address(4);
    address userFive = address(5);

    function setUp() public {
        voting = new Voting();
        // Propose some items
        voting.proposeItem("Banana");
        voting.proposeItem("Coffee");
        voting.proposeItem("Tea");
        voting.proposeItem("Beer");
        voting.proposeItem("Water");
    }

    function test_ProposeItem() public {
        voting.proposeItem("Coca Cola");

        assertEq(voting.itemId(), 6);
    }

    function test_ProposeItemInvalid() public {
        // Propose empty
        vm.expectRevert("Item must be present");
        voting.proposeItem("");

        console.log('Propose items length check passed');
    }

    function test_VoteForItem() public {
        // Vote for item
        vm.prank(userOne);
        voting.voteForItem(1);

        vm.prank(userTwo);
        voting.voteForItem(5);

        vm.prank(userThree);
        voting.voteForItem(5);

        vm.prank(userFour);
        voting.voteForItem(4);
        
        // Check if the votes for items have been updated
        assertEq(voting.votes(1), 1);
        assertEq(voting.votes(2), 0);
        assertEq(voting.votes(3), 0);
        assertEq(voting.votes(4), 1);
        assertEq(voting.votes(5), 2);
    }

    function test_InvalidItemId() public {
        // Vote for item
        vm.prank(userOne);
        vm.expectRevert("Provide valid Item id");
        voting.voteForItem(100);

        vm.prank(userTwo);
        vm.expectRevert("Provide valid Item id");
        voting.voteForItem(0);

        console.log('Invalid item id test passed');
    }

    function test_UserAlreadyVoted() public {
        // Vote for item
        vm.prank(userOne);
        voting.voteForItem(1);
        vm.prank(userOne);
        vm.expectRevert("User already voted");
        voting.voteForItem(1);

        console.log('User already voted test passed');
    }

    function test_GetWinner() public {
        // Vote for item
        vm.prank(userOne);
        voting.voteForItem(1);

        vm.prank(userTwo);
        voting.voteForItem(5);

        vm.prank(userThree);
        voting.voteForItem(5);

        vm.prank(userFour);
        voting.voteForItem(4);

        (uint ID, string memory Name) = voting.getWinner();
        console.log("Winner - {'ID': %d, 'Name': %s}", ID, Name);

        console.log("Votes received for %s = %d", Name, voting.votes(ID));
    }

    function test_NoWinner() public {
        // No one votes - every item has 0 votes
        vm.expectRevert("No winner found");
        voting.getWinner();

        console.log('No winner test passed');
    }

    function test_EqualVotes() public {
        // Vote for item: every item receives 1 vote
        vm.prank(userOne);
        voting.voteForItem(1);

        vm.prank(userTwo);
        voting.voteForItem(2);

        vm.prank(userThree);
        voting.voteForItem(3);

        vm.prank(userFour);
        voting.voteForItem(4);

        vm.prank(userFive);
        voting.voteForItem(5);
        
        vm.expectRevert("Equal votes for all items");
        voting.getWinner();

        console.log('No winner for equal vote test passed');
    }
}
