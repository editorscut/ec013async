import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry: Entry = Entry.blankEntry
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
}

extension EntryController {
  func next() {
  }
}

