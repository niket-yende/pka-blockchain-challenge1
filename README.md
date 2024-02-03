# CHALLENGE 1: ETHEREUM SMART CONTRACT 
## Problem: 
Develop a simple 'Voting' smart contract on the Ethereum blockchain using
Solidity. This contract should allow users to propose new items for voting, vote on
them, and declare a winner. The smart contract should include the following
functions:
1. ‘proposeItem(string memory _item)’: This function should allow any user to propose a
new item for voting.
1. ‘voteForItem(uint256 _itemId)’: This function should allow any user to vote for a specific
item using its ID. A user can only vote once.
1. ‘getWinner()’: This function should return the ID and the name of the item with the most
votes.

## Sample Inputs and Outputs:
### Input: 
1. `proposeItem("Blockchain")`
1. `voteForItem(1)`
1. `getWinner()`

### Output:
1. `A new item named 'Blockchain' is proposed for voting, the ID assigned to this item is 1.`
1. `A vote is cast for the item with ID 1.`
1. `If 'Blockchain' has the highest votes, it returns ‘{'ID': 1, 'Name': 'Blockchain'}’.`

## Test Case:
1. Propose a few items for voting.
1. Cast votes for the items.
1. Check if the item with the highest vote is returned by the ‘getWinner()’ function.

## Foundry Details:

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Pre-Requisite

[Foundry Installation](https://book.getfoundry.sh/getting-started/installation)

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test -vv
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Voting.s.sol:VotingScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
