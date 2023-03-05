import Foundation

class VendorUsingURLSession {
}

extension VendorUsingURLSession {
  func randomNumber() async throws -> Int {
    let (data, _)
    = try await URLSession.shared.data(from: URLConstants.intURL)
    if let string = String(data: data,
                           encoding: .utf8),
       let number = Int(string) {
      return number
    } else {
      throw UnexpectedDataFromServerError()
    }
  }
}



