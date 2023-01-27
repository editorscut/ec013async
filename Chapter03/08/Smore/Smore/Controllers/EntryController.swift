import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  private let receiver = StreamProvider.shared
  
  init() {
    Task {
      await listenForEntries()
    }
  }
}

extension EntryController {
  private func listenForEntries() async {
    do {
      for try await entry in receiver.entries {
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
