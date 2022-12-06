struct ErrorEntryVendor  {
  func entry(for count: Int) -> Entry {
    let imageName = imageName(for: count)
    return Entry(imageName: imageName)
  }
}

extension ErrorEntryVendor {
  private func imageName(for int: Int) -> String {
    let number = int % 50
    return "\(number).circle"
  }
}
