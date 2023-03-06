import Foundation

struct NumberVendor {
  let delay: TimeInterval
  
  func randomNumber() async -> Int {
    try? await Task.sleep(for: .seconds(delay))
    return Int.random(in: 1...50)
  }
}
