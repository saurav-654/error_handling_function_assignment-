// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    struct Proposal {
        string name;
        uint256 voteCount;
    }

    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;
    address public chairperson;
    uint256 public votingEnd;

    constructor(string[] memory proposalNames, uint256 durationInMinutes) {
        chairperson = msg.sender;
        votingEnd = block.timestamp + (durationInMinutes * 1 minutes);

        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    function vote(uint256 proposalId) public {
        require(block.timestamp < votingEnd, "Voting has ended");
        require(!hasVoted[msg.sender], "Already voted");
        require(proposalId < proposals.length, "Invalid proposal");

        if (block.timestamp >= votingEnd) {
            revert("Voting has ended");
        }
        if (hasVoted[msg.sender]) {
            revert("Already voted");
        }
        if (proposalId >= proposals.length) {
            revert("Invalid proposal");
        }

        hasVoted[msg.sender] = true;
        proposals[proposalId].voteCount++;
    }

    function winningProposal() public view returns (uint256) {
        uint256 winningVoteCount = 0;
        uint256 winningProposalId = 0;

        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposalId = i;
            }
        }

        assert(winningProposalId < proposals.length);
        return winningProposalId;
    }
}
