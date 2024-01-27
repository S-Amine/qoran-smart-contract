pragma solidity ^0.8.0;

// Import OpenZeppelin Contracts for access control
import "@openzeppelin/contracts/access/Ownable.sol";

contract CompetitionWinners is Ownable {

    // Define a struct to store participant information
    struct Participant {
        address participantAddress;
        string name;
        uint256 competitionId;
        uint256 score;
    }

    // Mapping to store participants for each competition
    mapping(uint256 => Participant[]) public participantsByCompetition;

    // Add a participant to a competition
    function addParticipant(uint256 _competitionId, Participant memory _participant) public {
        participantsByCompetition[_competitionId].push(_participant);
    }

    // Get all participants in a competition
    function getParticipants(uint256 _competitionId) public view returns (Participant[] memory) {
        return participantsByCompetition[_competitionId];
    }

    // Function to identify and output data about top winners
    function getTopWinners(uint256 _competitionId, uint256 _numWinners) public onlyOwner returns (Participant[] memory) {
        // Sort participants by score descending
        sortParticipantsByScore(_competitionId);

        // Extract top winners from sorted list
        Participant[] memory topWinners = new Participant[](_numWinners);
        for (uint i = 0; i < _numWinners; i++) {
            topWinners[i] = participantsByCompetition[_competitionId][i];
        }

        // Return top winners data
        return topWinners;
    }

    // Utility function to sort participants by score (descending)
    function sortParticipantsByScore(uint256 _competitionId) internal {
        // Bubble sort implementation for simplicity, consider using more efficient sorting methods
        Participant[] memory participants = participantsByCompetition[_competitionId];
        for (uint i = 0; i < participants.length - 1; i++) {
            for (uint j = i + 1; j < participants.length; j++) {
                if (participants[i].score < participants[j].score) {
                    (participants[i], participants[j]) = (participants[j], participants[i]);
                }
            }
        }
    }
}