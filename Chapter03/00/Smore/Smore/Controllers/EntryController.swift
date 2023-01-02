import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
}

extension EntryController {
  func nextEntry() {
  }
}
