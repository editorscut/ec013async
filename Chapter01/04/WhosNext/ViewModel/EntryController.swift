import Foundation

@MainActor
class EntryController: ObservableObject {
  private var count = 0
  @Published private(set) var entries: [Entry] = []
  private let vendor = AsyncEntry()
}

extension EntryController {
  func next() {
    increaseCount()
    let entriesCopy = entries
    Task {
      let newEntry = await vendor.entry(for: count)
      entries = entriesCopy + [newEntry]
    }
  }
}

extension EntryController {
  private func increaseCount() {
    count += 1
  }
}
