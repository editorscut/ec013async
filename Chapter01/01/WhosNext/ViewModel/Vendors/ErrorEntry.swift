struct ErrorEntry  {
  func entry(for count: Int) -> Entry {
    let imageName = imageName(for: count)
    return Entry(imageName: imageName)
  }
}

extension ErrorEntry {
  private func imageName(for int: Int) -> String {
    let number = int % 50
    return "\(number).circle"
  }
}
