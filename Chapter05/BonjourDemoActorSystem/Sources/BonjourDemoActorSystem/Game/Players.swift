/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Player actor implementations for the game.
*/

import Distributed

public typealias MyPlayer = LocalNetworkPlayer
public typealias OpponentPlayer = LocalNetworkPlayer

// ======= ------------------------------------------------------------------------------------------------------------
// - MARK: GamePlayer Protocol

public protocol GamePlayer: DistributedActor, Codable where ID == ActorIdentity {

    /// Ask this player to make a move of their own.
    func makeMove() async throws -> GameMove
    
    /// Inform this player their opponent has made the passed `move`.
    func opponentMoved(_ move: GameMove) async throws
}

// ======= ------------------------------------------------------------------------------------------------------------
// - MARK: Local Networking Player

/// A player implementation that can handle remote "your move now" calls.
///
/// Since we're playing with an actual human here, the make move is delegated to the UI where the move will be made,
/// once the human player makes a decision, a reply is sent to the `makeMove()` call.
public distributed actor LocalNetworkPlayer: GamePlayer {
    public typealias ActorSystem = SampleLocalNetworkActorSystem

    let team: CharacterTeam
    let model: GameViewModel

    var movesMade: Int = 0

    public init(team: CharacterTeam, model: GameViewModel, actorSystem: ActorSystem) {
        self.team = team
        self.model = model
        self.actorSystem = actorSystem
    }

    public distributed func makeMove() async -> GameMove {
        let field = await model.humanSelectedField()

        movesMade += 1
        let move = GameMove(
            playerID: self.id,
            position: field,
            team: team,
            teamCharacterID: movesMade % 2)

        return move
    }

    public distributed func makeMove(at position: Int) async -> GameMove {
        let move = GameMove(
            playerID: id,
            position: position,
            team: team,
            teamCharacterID: movesMade % 2)

        log("player", "Player makes move: \(move)")
        _ = await model.userMadeMove(move: move)

        movesMade += 1
        return move
    }

    public distributed func opponentMoved(_ move: GameMove) async throws {
        do {
            try await model.markOpponentMove(move)
        } catch {
            log("player", "Opponent made illegal move! \(move)")
        }
    }

    public distributed func startGameWith(opponent: OpponentPlayer, startTurn: Bool) async {
        log("local-network-player", "Start game with \(opponent.id), startTurn:\(startTurn)")
        await model.foundOpponent(opponent, myself: self, informOpponent: false)

        log("local-network-player", "Wait for opponent move: self id: \(self.id)")
        log("local-network-player", "Wait for opponent move: self id hash: \(self.id.hashValue)")

        log("local-network-player", "Wait for opponent move: self id: \(opponent.id)")
        log("local-network-player", "Wait for opponent move: self id hash: \(opponent.id.hashValue)")

        log("local-network-player", "Wait for opponent move: \(self.id < opponent.id)")
        log("local-network-player", "Wait for opponent move: \(self.id.hashValue < opponent.id.hashValue)")
        // we use some arbitrary method to pick who goes first
        await model.waitForOpponentMove(shouldWaitForOpponentMove(myselfID: self.id, opponentID: opponent.id))
    }
}

// ======= -------
// - MARK: Helper functions

func shouldWaitForOpponentMove(myselfID: ActorIdentity, opponentID: ActorIdentity) -> Bool {
    myselfID.hashValue < opponentID.hashValue
}
