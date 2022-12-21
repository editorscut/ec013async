struct AsyncEntryVendor  {
  func entry(for count: Int) async -> Entry {
    let imageName = await imageName(for: count)
    return Entry(imageName: imageName)
  }
}

extension AsyncEntryVendor {
  private func imageName(for int: Int) async -> String {
    let number = int % 51
    try? await Task.sleep(for:
                          .seconds(Int.random(in: 2...6)))
    return "\(number).circle"
  }
}
