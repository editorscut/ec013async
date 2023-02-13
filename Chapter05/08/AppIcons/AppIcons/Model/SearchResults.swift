struct SearchResults: Codable {
    let resultCount: Int
    let apps: [AppInfo]
  
  enum CodingKeys: String, CodingKey {
    case apps = "results"
    case resultCount
  }
}

extension SearchResults: CustomStringConvertible {
    var description: String {
        return "\(resultCount) results \n \(apps)\n"
    }
}

