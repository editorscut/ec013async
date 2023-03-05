class VendorUsingURLSession {
}

extension VendorUsingURLSession {
  func selectRandomNumber(with completion:
                          @escaping (Int) -> Void) {
    let number = Int.random(in: 1...50)
    completion(number)
  }
}


