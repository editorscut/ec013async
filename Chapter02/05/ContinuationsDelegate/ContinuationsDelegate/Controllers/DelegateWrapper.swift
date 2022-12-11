import DelegateSupport

class DelegateWrapper {
  lazy private var numberVendor
    = VendorUsingDelegates(delegate: self)
  var requestContinuation: CheckedContinuation<(), Never>?
  var receiveContinuation: CheckedContinuation<(Int, Int),
                                                Error>?
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
  func receiveRandomEntryNumber() async throws -> (number: Int,
                                                   delta: Int) {
    try await withCheckedThrowingContinuation {continuation in
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
    receiveContinuation?
      .resume(with: numberResult(number: number,
                                 delta: vendor.delta))
    receiveContinuation = nil
  }
}

func numberResult(number: Int, delta: Int)
                -> Result<(Int, Int), MultipleOfFiveError> {
  if number.isMultiple(of: 5) {
    return .failure(MultipleOfFiveError(number: number))
  } else {
    return .success((number, delta))
  }
}
