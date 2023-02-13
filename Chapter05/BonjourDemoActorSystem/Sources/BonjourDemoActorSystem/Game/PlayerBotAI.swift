/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Player bot "AI" which handles a bot opponents decision process for making a move.
*/

import Distributed

protocol PlayerBotAI {
    mutating func decideNextMove(given gameState: inout GameState) throws -> GameMove
}

/// The difficulty of the AI. We only implement an "easy" mode which picks moves at random.
///
/// This type is `Sendable` but not `Codable`; We are able to pass it to a distributed actor while initializing it,
/// however we cannot query it (without making it `Codable`) from a distributed actor since that may potentially
/// involve a remote call, which this type (for sake or argument), cannot handle (as it is not `Codable`).
public enum BotAIDifficulty: Sendable {
    case easy
}

class RandomPlayerBotAI: PlayerBotAI {
    let playerID: ActorIdentity
    let team: CharacterTeam
    
    private var movesMade: Int = 0
    
    init(playerID: ActorIdentity, team: CharacterTeam) {
        self.playerID = playerID
        self.team = team
    }
    
    init(playerID: LocalTestingDistributedActorSystem.ActorID, team: CharacterTeam) {
        self.playerID = .init(id: playerID.id)
        self.team = team
    }
    
     func decideNextMove(given gameState: inout GameState) throws -> GameMove {
        guard gameState.checkWin() == nil else {
            throw NoMoveAvailable()
        }
        
        var selectedPosition: Int?
        for position in gameState.availablePositions.shuffled() {
            if gameState.at(position: position) == nil {
                selectedPosition = position
                break
            }
        }
        guard let selectedPosition = selectedPosition else {
            throw NoMoveAvailable()
        }
        
        let move = GameMove(
            playerID: playerID,
            position: selectedPosition,
            team: team,
            teamCharacterID: CharacterTeam.characterID(for: movesMade))
        movesMade += 1
        
        try gameState.mark(move)
        return move
    }
}

struct NoMoveAvailable: Error {}
