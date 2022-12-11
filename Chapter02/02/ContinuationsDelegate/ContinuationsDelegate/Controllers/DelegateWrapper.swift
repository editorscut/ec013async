import DelegateSupport

class DelegateWrapper {
  lazy private var numberVendor
    = VendorUsingDelegates(delegate: self)
  var numberContinuation: CheckedContinuation<Int, Never>?
}

extension DelegateWrapper {
  @MainActor
  func randomEntryNumber() async -> Int {
    return await withCheckedContinuation {continuation in
      numberContinuation = continuation
      numberVendor.randomNumber()
    }
  }
}

extension DelegateWrapper: VendorDelegate {
  func vendorWillSelect(_ vendor: VendorUsingDelegates) {
  }
  
  func vendorDidSelect(_ vendor: VendorUsingDelegates,
                       number: Int) {
    numberContinuation?.resume(returning: number)
  }
}
