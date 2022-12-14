import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  private let receiver = CombineReceiver()
  
  init() {
    Task {
      await listenForEntries()
    }
  }
}

extension EntryController {
  private func listenForEntries() async {
    for await entry in receiver.entries {
      entries.append(entry)
    }
  }
}

extension EntryController {
  func nextEntry() {
    IntPublisher.shared.selectNextNumber()
  }
}
