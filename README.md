### SimpleVoting Contract 
---

## Overview

The `SimpleVoting` contract is a smart contract that allows participants to vote on a set of proposals within a defined voting period. The contract is written in Solidity for deployment on Ethereum-compatible blockchains.

## Features

- **Proposals:** Allows multiple proposals to be set during contract initialization.
- **Voting:** Allows participants to cast a vote for a proposal within the voting period.
- **Vote Counting:** Keeps track of the vote count for each proposal.
- **Result Declaration:** Returns the proposal with the highest vote count after the voting period ends.

## Contract Structure

### `Proposal` Struct

```solidity
struct Proposal {
    string name;
    uint256 voteCount;
}
```

This struct represents a proposal with a name and a vote count.

### State Variables

- `proposals`: An array of `Proposal` structs to store the proposals.
- `hasVoted`: A mapping to track if an address has already voted.
- `chairperson`: The address that deploys the contract and initializes it.
- `votingEnd`: The timestamp indicating when the voting period ends.

### Constructor

```solidity
constructor(string[] memory proposalNames, uint256 durationInMinutes)
```

- Initializes the `chairperson` as the contract deployer.
- Sets the `votingEnd` timestamp based on the current block time and the specified duration in minutes.
- Initializes the proposals with the given names and sets their initial vote count to zero.

### `vote` Function

```solidity
function vote(uint256 proposalId) public
```

- Allows an address to vote for a proposal by providing its ID.
- Checks if the voting period is still open.
- Ensures that the address has not voted before.
- Validates the proposal ID.
- Increments the vote count for the specified proposal and marks the address as having voted.

### `winningProposal` Function

```solidity
function winningProposal() public view returns (uint256)
```

- Returns the ID of the proposal with the highest vote count.
- Iterates through the proposals to find the one with the maximum votes.

## Usage

### Deploying the Contract

1. **Deploy the contract:**
   - Specify an array of proposal names.
   - Set the voting duration in minutes.
   ```solidity
   string[] memory proposalNames = ["Proposal 1", "Proposal 2", "Proposal 3"];
   uint256 durationInMinutes = 30;
   SimpleVoting voting = new SimpleVoting(proposalNames, durationInMinutes);
   ```

2. **Casting a Vote:**
   - Call the `vote` function with the proposal ID (0-based index).
   ```solidity
   voting.vote(1);
   ```

3. **Checking the Winning Proposal:**
   - Call the `winningProposal` function to get the ID of the proposal with the highest vote count.
   ```solidity
   uint256 winner = voting.winningProposal();
   ```

