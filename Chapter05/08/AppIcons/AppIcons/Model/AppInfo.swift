import Foundation

struct AppInfo: Codable, Identifiable {
  let id = UUID()
  let name: String
  let artworkURL: URL
  
  enum CodingKeys: String, CodingKey {
    case name = "trackCensoredName"
    case artworkURL = "artworkUrl60"
  }
}

extension AppInfo: CustomStringConvertible {
  var description: String {
    name
  }
}

