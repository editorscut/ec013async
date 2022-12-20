import ClosureSupport

class ClosureWrapper {
  let vendor = ClosureBasedVendor()
}

extension ClosureWrapper {
  @MainActor
  func randomNumber() async -> (Int, Bool) {
    await withCheckedContinuation { continuation in
      vendor.selectRandomNumber { number, isGreater in
        continuation.resume(returning: (number, isGreater))
      }
    }
  }
}
