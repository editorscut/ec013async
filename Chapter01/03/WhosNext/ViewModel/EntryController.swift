import Foundation

class EntryController: ObservableObject {
  private var count = 0
  @Published private(set) var entries: [Entry] = []
  private let vendor = SleepingEntry()
}

extension EntryController {
  func next() {
    increaseCount()
    let entriesCopy = entries
    let newEntry = vendor.entry(for: count)
    entries = entriesCopy + [newEntry]
  }
}

extension EntryController {
  private func increaseCount() {
    count += 1
  }
}
