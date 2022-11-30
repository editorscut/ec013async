struct ErrorEntry  {
  func entry(for count: Int) -> Entry {
    do {
      let imageName = try imageName(for: count)
      return Entry(imageName: imageName)
    } catch {
      print(error)
      return Entry.errorEntry
    }
  }
}

extension ErrorEntry {
  private func imageName(for int: Int) throws -> String {
    if int.isMultiple(of: 5) {
      throw DivisibleByFiveError(number: int)
    } else {
      let number = int % 50
      return "\(number).circle"
    }
  }
}
