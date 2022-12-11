import DelegateSupport

class DelegateWrapper {
  lazy private var numberVendor
    = VendorUsingDelegates(delegate: self)
  var requestContinuation: CheckedContinuation<(), Never>?
  var receiveContinuation: CheckedContinuation<(Int, Int), Never>?
}

extension DelegateWrapper {
  @MainActor
  func requestRandomEntryNumber() async {
    await withCheckedContinuation {continuation in
      requestContinuation = continuation
      numberVendor.randomNumber()
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
  func vendorWillSelect(_ vendor: VendorUsingDelegates) {
    requestContinuation?.resume(returning: ())
    requestContinuation = nil
  }
  
  func vendorDidSelect(_ vendor: VendorUsingDelegates,
                       number: Int) {
    requestContinuation?.resume(returning: ())
    receiveContinuation?.resume(returning: (number, vendor.delta))
    receiveContinuation = nil
  }
}
