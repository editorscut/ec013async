import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  @Published private(set) var entries2: [Entry] = []
  @Published private(set) var entryPairs: [EntryPair] = []
  
  private let plain = AutoEntryVendor(delay: 2.0)
  private let filled = AutoEntryVendor(delay: 1.5,
                                       isFilled: true)

  init() {
    Task {
      await listenForEntries()
    }
    Task {
      await listenForEntries2()
    }
  }
}

extension EntryController {
  private func listenForEntries() async {
    for await entry in plain.entries {
      entries.append(entry)
    }
  }
  private func listenForEntries2() async {
    for await entry in filled.entries {
      entries2.append(entry)
    }
  }
}
