struct NumberVendor {
  let delay: Double
  
  func randomNumber() async -> Int {
    try? await Task.sleep(for: .seconds(delay))
    return Int.random(in: 1...50)
  }
}

