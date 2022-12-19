import ClosureSupport

class ClosureWrapper {
  let vendor = VendorUsingClosures()
}

extension ClosureWrapper {
  func randomNumber() async -> (Int, Bool) {
    await withCheckedContinuation { continuation in
      vendor.randomNumber { number, isGreater in
        continuation.resume(returning: (number, isGreater))
      }
    }
  }
}
