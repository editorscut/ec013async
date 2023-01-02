import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  @Published private(set) var entries2: [Entry] = []
  @Published private(set) var entryPairs: [EntryPair] = []
}

