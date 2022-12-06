struct ErrorEntryVendor  {
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

extension ErrorEntryVendor {
  private func imageName(for int: Int) throws -> String {
    if int.isMultiple(of: 5) {
      throw MultipleOfFiveError(number: int)
    } else {
      let number = int % 50
      return "\(number).circle"
    }
  }
}
