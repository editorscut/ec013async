import ClosureSupport

class ClosureWrapper {
  private let vendor = ClosureBasedVendor()
}

extension ClosureWrapper {
  func randomNumber() async -> (Int, Bool) {
    await withCheckedContinuation { continuation in
      vendor.selectRandomNumber { number, isGreater in
        continuation.resume(returning: (number, isGreater))
      }
    }
  }
}
