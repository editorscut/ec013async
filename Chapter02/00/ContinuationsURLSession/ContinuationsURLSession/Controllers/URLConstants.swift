import Foundation

enum URLConstants {}

extension URLConstants {
  public static var intURL: URL {
    urlComponents.path = "/number"
    guard let url = urlComponents.url else {
      fatalError("intURL is not a valid URL")
    }
    return url
  }
  
  public static var entryURL: URL {
    urlComponents.path = "/entry"
    guard let url = urlComponents.url else {
      fatalError("entryURL is not a valid URL")
    }
    return url
  }
}

fileprivate(set) var urlComponents: URLComponents = {
  var components = URLComponents()
  components.scheme = "http"
  components.host = "localhost"
  components.port = 8080
  return components
}()

