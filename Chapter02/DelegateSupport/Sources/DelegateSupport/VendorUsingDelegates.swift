public class VendorUsingDelegates {
  let delegate: VendorDelegate
  public private(set) var number = 0
  public private(set) var delta = 0
  
  public init(delegate: VendorDelegate) {
    self.delegate = delegate
  }
}

extension VendorUsingDelegates {
  @MainActor
  public func randomNumber() {
    Task {
      let numberBeforeChange = number
      delegate.vendorWillSelect(self)
      try? await Task.sleep(for: .seconds(0.5))
      number = Int.random(in: 1...50)
      delta = number - numberBeforeChange
      delegate.vendorDidSelect(self,
                               number: number)
    }
  }
}
