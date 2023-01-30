import Foundation

struct NumberVendor {
  let delay: TimeInterval
  
  func randomNumber() async throws -> Int {
    try await Task.sleep(for: .seconds(delay))
    return Int.random(in: 1...50)
  }
}

