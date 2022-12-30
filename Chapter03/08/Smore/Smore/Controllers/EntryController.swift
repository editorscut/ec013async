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
    do {
      for try await entry in StreamProvider.shared.entryStream {
        entries.append(entry)
      }
    } catch {
      entries.append(errorEntry())
    }
  }
}

extension EntryController {
  func nextEntry() {
    StreamProvider.shared.selectNextNumber()
  }
}
