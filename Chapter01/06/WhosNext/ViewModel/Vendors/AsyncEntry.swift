struct AsyncEntry  {
  func entry(for count: Int) async -> Entry {
    do {
      let imageName = try await imageName(for: count) + suffix
      return Entry(imageName: imageName)
    } catch {
      return Entry.errorEntry
    }
  }
}

extension AsyncEntry {
  private func imageName(for int: Int) async throws -> String {
    if int.isMultiple(of: 5) {
      throw DivisibleByFiveError(number: int)
    }
    let number = int % 50
    try? await Task.sleep(for: .seconds(1))
    return number.description
  }
}

extension AsyncEntry {
  private var suffix: String {
    get async {
      try? await Task.sleep(nanoseconds: nanosecondsDelay)
      return ".circle"
    }
  }
}

extension AsyncEntry {
  private var nanosecondsDelay: UInt64 {
    1_000_000_000 *  UInt64.random(in: 2...6)
  }
}
