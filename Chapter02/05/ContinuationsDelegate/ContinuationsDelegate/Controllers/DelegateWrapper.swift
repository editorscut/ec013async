import DelegateSupport

class DelegateWrapper {
  lazy private var numberVendor
    = DelegatingVendor(delegate: self)
  var requestContinuation: CheckedContinuation<Void, Never>?
  var receiveContinuation: CheckedContinuation<(Int, Int),
                                                Error>?
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
  func receiveRandomEntryNumber() async throws -> (number: Int,
                                                   delta: Int) {
    try await withCheckedThrowingContinuation {continuation in
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
