class ClosureBasedVendor {
  private var number = 0
}

extension ClosureBasedVendor {
  func selectRandomNumber(with completion:
                          @escaping (Int, Bool) -> Void) {
    Task {
      let numberBeforeChange = number
      try? await Task.sleep(for: .seconds(0.5))
      number = Int.random(in: 1...50)
      let isGreater = number > numberBeforeChange
      await MainActor.run {
        completion(number, isGreater)
      }
    }
  }
}
