import DelegateSupport

class DelegateWrapper {
  lazy private var numberVendor
  = DelegatingVendor(delegate: self)
  var numberContinuation: CheckedContinuation<Int, Never>?
}

extension DelegateWrapper {
  @MainActor
  func randomNumber() async -> Int {
    await withCheckedContinuation { continuation in
      numberContinuation = continuation
      numberVendor.selectRandomNumber()
    }
  }
}

extension DelegateWrapper: VendorDelegate {
  func vendorWillSelect(_ vendor: DelegatingVendor) {
    
  }
  
  func vendor(_ vendor: DelegatingVendor,
              didSelect number: Int) {
    numberContinuation?.resume(returning: number)
    numberContinuation = nil
  }
}
