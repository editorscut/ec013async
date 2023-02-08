import Foundation

let ephemeralURLSession = URLSession(configuration: .ephemeral)

func url(for rawTerm: String) -> URL {
  let formattedTerm = applyFormatting(to: rawTerm)
  var components = iTunesURLBase
  components
    .queryItems?
    .append(URLQueryItem(name: "term",
                         value: formattedTerm))
  guard let url = components.url else {
    fatalError("Not a valid URL using search term: \(rawTerm)")
  }
  return url
}

fileprivate var iTunesURLBase: URLComponents {
  var urlComponents = URLComponents()
  urlComponents.scheme = "https"
  urlComponents.host = "itunes.apple.com"
  urlComponents.path = "/search"
  urlComponents.queryItems
  = [URLQueryItem(name: "entity", value: "software"),
     URLQueryItem(name: "limit", value: "50")]
  return urlComponents
}

fileprivate func applyFormatting(to rawTerm: String) -> String {
  rawTerm.replacingOccurrences(of: " ",
                               with: "+")
}
