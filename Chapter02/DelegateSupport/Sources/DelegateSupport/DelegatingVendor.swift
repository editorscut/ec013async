public class DelegatingVendor {
  weak var delegate: VendorDelegate?
  public private(set) var number = 0
  public private(set) var delta = 0
  
  public init(delegate: VendorDelegate) {
    self.delegate = delegate
  }
}

extension DelegatingVendor {
  @MainActor
  public func selectRandomNumber() {
    guard let delegate else {return}
    Task {
      let numberBeforeChange = number
      delegate.vendorWillSelect(self)
      try? await Task.sleep(for: .seconds(0.5))
      number = Int.random(in: 1...50)
      delta = number - numberBeforeChange
      delegate.vendor(self,
                      didSelect: number)
    }
  }
}
