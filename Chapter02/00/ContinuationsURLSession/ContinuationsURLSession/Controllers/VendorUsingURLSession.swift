class VendorUsingURLSession {
}

extension VendorUsingURLSession {
  func randomNumber(completion: @escaping (Int) -> ()) {
    let number = Int.random(in: 1...50)
    completion(number)
  }
}


