public class VendorUsingClosures {
  public private(set) var number = 0
  public init() {  }
}

extension VendorUsingClosures {
  @MainActor
  public func randomNumber(completion: @escaping (Int, Int) -> Void) {
    Task {
      let numberBeforeChange = number
      try? await Task.sleep(for: .seconds(0.5))
      number = Int.random(in: 1...50)
      completion(number, number - numberBeforeChange)
    }
  }
}


