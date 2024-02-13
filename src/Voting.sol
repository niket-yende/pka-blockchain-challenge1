// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title Voting
 * @dev A smart contract for conducting voting on proposed items.
 *      Each item can be proposed, and users can vote for their preferred items.
 */
contract Voting is ReentrancyGuard {
    uint256 public itemId;
    uint64 public immutable itemLimit;
    
    mapping(uint256 => uint64) public votes;
    mapping(address => bool) private hasVoted;
    uint[] public items;

    struct Item {
        uint ID;
        string Name;
    }
    mapping(uint256 => Item) itemMap;
    mapping(string => bool) public itemExist;

    event VoteSubmitted(address _voter);

    /**
     * @dev Constructor to initialize the contract with the specified item limit.
     * @param _itemLimit The maximum number of items that can be proposed.
     */
    constructor(uint64 _itemLimit) {
        itemLimit = _itemLimit;
    }

    /**
     * @dev Allows a user to propose an item for voting.
     * @param _item The name of the item to propose.
     * @return _itemId The unique ID of the proposed item.
     */
    function proposeItem(string calldata _item) external returns (uint256) {
        require(bytes(_item).length > 0, 'Item must be present');
        require(!itemExist[_item], 'Duplicate item added');
        uint _itemId = itemId++;
        // Item limit added to protect contract from denial of service (Sybil attack)
        require(itemId <= itemLimit, "Exceeded item limit");
        itemMap[_itemId] = Item(_itemId, _item);
        itemExist[_item] = true;
        items.push(_itemId);
        return _itemId;
    }

    /**
     * @dev Allows a user to vote for a specific item.
     * @param _itemId The ID of the item to vote for.
     */
    function voteForItem(uint256 _itemId) external nonReentrant {
        // Check required conditions
        require(_itemId > 0 && _itemId <= items.length, 'Provide valid Item id');
        require(!hasVoted[msg.sender], 'User already voted');
        
        // Emit the vote submitted event
        emit VoteSubmitted(msg.sender);

        // Store user vote for an itemId
        hasVoted[msg.sender] = true;
        votes[_itemId]++; 
    }

    /**
     * @dev Retrieves the winner of the voting.
     * @return id The ID of the winning item.
     * @return name The name of the winning item.
     */
    function getWinner() public view returns (uint, string memory) {
        uint highestVote = 0;
        // Local caching
        uint[] memory _items = items;
        Item memory winner = itemMap[0];
        bool initialized = false;
        
        for (uint256 index = 1; index <= _items.length; index++) {
            Item memory item = itemMap[index];
            uint256 itemVotes = votes[item.ID];
            if(itemVotes > highestVote) {
                highestVote = itemVotes;
                winner = item;
                initialized = true;
            }
        }
        require(initialized, "No winner found");
        return (winner.ID, winner.Name);
    }
}