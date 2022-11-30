class Example {
  func emphasize(string: String?) -> String {
    if let string {
      return string.uppercased() + "!"
    } else {
      return ""
    }
  }
}
