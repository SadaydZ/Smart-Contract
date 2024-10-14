pragma solidity ^0.8.0;

contract Ballot {
    struct Candidate {
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;

    uint public candidatesCount;
    uint public winningProposalIndex;

    constructor(string[] memory candidateNames) {
        for (uint i = 0; i < candidateNames.length; i++) {
            addCandidate(candidateNames[i]);
        }
    }

    function addCandidate(string memory name) private {
        candidates[candidatesCount] = Candidate(name, 0);
        candidatesCount++;
    }

    function vote(uint candidateIndex) public {
        require(!voters[msg.sender], "You have already voted.");
        require(candidateIndex < candidatesCount, "Invalid candidate index.");
        
        voters[msg.sender] = true;
        candidates[candidateIndex].voteCount++;

        if (candidates[candidateIndex].voteCount > candidates[winningProposalIndex].voteCount) {
            winningProposalIndex = candidateIndex;
        }
    }

    function winningProposal() public view returns (uint) {
        return winningProposalIndex;
    }

    function winnerName() public view returns (string memory) {
        return candidates[winningProposalIndex].name;
    }
}