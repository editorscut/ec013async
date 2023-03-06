import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  
  init() {
    Task {
      await listenForEntries()
    }
  }
}

extension EntryController {
  private func listenForEntries() async {
    for await entry in CombineReceiver.shared.entries {
      entries.append(entry)
    }
  }
}

extension EntryController {
  func nextEntry() {
    IntPublisher.shared.selectNextNumber()
  }
}
