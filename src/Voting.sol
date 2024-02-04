// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

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

    constructor(uint64 _itemLimit) {
        itemLimit = _itemLimit;
    }

    function proposeItem(string calldata _item) external returns (uint256) {
        require(bytes(_item).length > 0, 'Item must be present');
        uint _itemId = itemId++;
        // Item limit added to protect contract from denial of service (Sybil attack)
        require(itemId <= itemLimit, "Exceeded item limit");
        // itemId++;
        itemMap[_itemId] = Item(_itemId, _item);
        items.push(_itemId);
        return _itemId;
    }

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