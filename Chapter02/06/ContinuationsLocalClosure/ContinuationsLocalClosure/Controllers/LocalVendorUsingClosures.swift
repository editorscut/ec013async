class LocalVendorUsingClosures {
  private var number = 0
}

extension LocalVendorUsingClosures {
  @MainActor
  func randomNumber(completion: @escaping (Int, Bool) -> ()) {
    Task {
      let numberBeforeChange = number
      try? await Task.sleep(for: .seconds(0.5))
      number = Int.random(in: 1...50)
      let isGreater = number > numberBeforeChange
      completion(number, isGreater)
    }
  }
}
