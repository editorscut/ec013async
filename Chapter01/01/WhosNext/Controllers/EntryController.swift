import Combine

class EntryController: ObservableObject {
  private var count = 0
  @Published private(set) var entries: [Entry] = []
  private let vendor = PlainEntryVendor()
}

extension EntryController {
  func next() {
    count += 1
    let entriesCopy = entries
    let newEntry = vendor.entry(for: count)
    entries = entriesCopy + [newEntry]
  }
}
