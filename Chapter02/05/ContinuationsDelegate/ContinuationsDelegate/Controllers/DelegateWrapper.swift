import DelegateSupport

class DelegateWrapper {
  lazy private var numberVendor
  = DelegatingVendor(delegate: self)
  var requestContinuation: CheckedContinuation<Void, Never>?
  var receiveContinuation: CheckedContinuation<(Int, Int), Error>?
}

@MainActor
extension DelegateWrapper {
  func requestRandomNumber() async {
    await withCheckedContinuation { continuation in
      requestContinuation = continuation
      numberVendor.selectRandomNumber()
    }
  }
  
  func receiveRandomNumber() async throws -> (Int, Int) {
    try await withCheckedThrowingContinuation { continuation in
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
    receiveContinuation?.resume(with: result(number: number,
                                             delta: vendor.delta))
    receiveContinuation = nil
  }
}

func result(number: Int, delta: Int)
                -> Result<(Int, Int), MultipleOfFiveError> {
  if number.isMultiple(of: 5) {
    return .failure(MultipleOfFiveError(number: number))
  } else {
    return .success((number, delta))
  }
}
