public class VendorUsingClosures {
  public private(set) var number = 0
  public private(set) var delta = 0
  
  public init() {  }
}

extension VendorUsingClosures {
  public func prepareForSelection(completion: @escaping (VendorUsingClosures) -> ()) {
    completion(self)
  }
  
  @MainActor
  public func randomNumber(completion: @escaping (VendorUsingClosures, Int) -> ()) {
    Task {
      let numberBeforeChange = number
      try? await Task.sleep(for: .seconds(0.5))
      number = Int.random(in: 1...50)
      delta = number - numberBeforeChange
      completion(self, number)
    }
  }
}


