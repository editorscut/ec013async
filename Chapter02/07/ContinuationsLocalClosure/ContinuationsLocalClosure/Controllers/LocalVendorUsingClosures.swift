class LocalVendorUsingClosures {
  private var number = 0
}

extension LocalVendorUsingClosures {
  func randomNumber() async -> (Int, Bool) {
    let numberBeforeChange = number
    try? await Task.sleep(for: .seconds(0.5))
    number = Int.random(in: 1...50)
    let isGreater = number > numberBeforeChange
    return (number, isGreater)
  }
}
