struct DivisibleByFiveError: Error {
  let number: Int
}

extension DivisibleByFiveError: CustomStringConvertible {
  var description: String {
    "\(number) is divisible by 5"
  }
}
