class EntryController: ObservableObject {
  private var count = 0
}

extension EntryController {
  func next() {
    increaseCount()
  }
}

extension EntryController {
  private func increaseCount() {
    count += 1
  }
}
