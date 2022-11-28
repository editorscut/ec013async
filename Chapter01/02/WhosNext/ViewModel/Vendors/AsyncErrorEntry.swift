struct AsyncErrorEntry {
  private var currentCount = 0
  
  mutating func entry(for count: Int) -> Entry {
    currentCount = count
    return Entry(imageName: imageName)
  }
}

extension AsyncErrorEntry {
  private var imageName: String {
    get {
      let number = currentCount % 50
      return "\(number).circle"
    }
  }
}

extension AsyncErrorEntry {
  private var nanosecondsDelay: UInt64 {
    1_000_000_000 *  UInt64.random(in: 2...6)
  }
}
