struct MultipleOfFiveError: Error {
  let number: Int
}

extension MultipleOfFiveError: CustomStringConvertible {
  var description: String {
    "\(number) is divisible by 5"
  }
}
