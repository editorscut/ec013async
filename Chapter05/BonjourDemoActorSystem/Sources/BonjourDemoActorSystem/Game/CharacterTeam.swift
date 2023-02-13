/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Enum used to represent the team a player is part of. Each team has a few characters associated that are used for the moves the player will be making.
*/

/// Represents which "team" a player is playing for.
/// Currently two teams are available,
public enum CharacterTeam: Sendable, Codable {
    case fish
    case rodents

    public var emojiArray: [String] {
        switch self {
        case .fish: return ["🐟", "🐠", "🐡"]
        case .rodents: return ["🐹", "🐭", "🐰"]
        }
    }

    public func select(_ index: Int) -> String {
        let arr = emojiArray
        return arr[index % arr.count]
    }

    static func characterID(for moveNumber: Int) -> Int {
        guard moveNumber > 0 else {
            return 0
        }

        return moveNumber % Self.fish.emojiArray.count
    }

    public func characterID(for moveNumber: Int) -> Int {
        Self.characterID(for: moveNumber)
    }

    public init?(_ emoji: String) {
        switch emoji {
        case "🐟", "🐠", "🐡": self = .fish
        case "🐹", "🐭", "🐰": self = .rodents
        default: return nil
        }
    }

    public var tag: String {
        switch self {
        case .fish: return "fish"
        case .rodents: return "rodents"
        }
    }
}
