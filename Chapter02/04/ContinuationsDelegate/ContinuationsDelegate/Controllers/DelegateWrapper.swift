import DelegateSupport

class DelegateWrapper {
  lazy private var numberVendor
    = DelegatingVendor(delegate: self)
  var requestContinuation: CheckedContinuation<Void, Never>?
  var receiveContinuation: CheckedContinuation<(Int, Int), Never>?
}

extension DelegateWrapper {
  @MainActor
  func requestRandomEntryNumber() async {
    await withCheckedContinuation {continuation in
      requestContinuation = continuation
      numberVendor.selectRandomNumber()
    }
  }
  @MainActor
  func receiveRandomEntryNumber() async -> (number: Int, delta: Int) {
    await withCheckedContinuation {continuation in
      receiveContinuation = continuation
    }
  }
}

extension DelegateWrapper: VendorDelegate {
  func vendorWillSelect(_ vendor: DelegatingVendor) {
    requestContinuation?.resume(returning: ())
    requestContinuation = nil
  }
  
  func vendor(_ vendor: DelegatingVendor,
              didSelect number: Int) {
    receiveContinuation?.resume(returning: (number,
                                            vendor.delta))
    receiveContinuation = nil
  }
}
