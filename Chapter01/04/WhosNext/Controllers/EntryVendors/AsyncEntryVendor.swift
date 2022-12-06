struct AsyncEntryVendor  {
  func entry(for count: Int) async -> Entry {
    let imageName = await imageName(for: count)
    return Entry(imageName: imageName)
  }
}

extension AsyncEntryVendor {
  private func imageName(for int: Int) async -> String {
    let number = int % 50
    return "\(number).circle"
  }
}

extension AsyncEntryVendor {
  private var nanosecondsDelay: UInt64 {
    1_000_000_000 *  UInt64.random(in: 2...6)
  }
}
