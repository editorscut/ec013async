import Combine
import AsyncAlgorithms

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  @Published private(set) var entryPairs: [EntryPair] = []
  
  private let plain = AutoEntryVendor(delay: 2.0)
  private let filled = AutoEntryVendor(delay: 1.5,
                                       isFilled: true)
  
  init() {
//    Task {
//      await listenForEntries()
//    }
    Task {
      await listenForEntryPairs()
    }
  }
}

extension EntryController {
//  private func listenForEntries() async {
//    for await entry in plain.entries {
//      entries.append(entry)
//    }
//  }
  private func listenForEntryPairs() async {
    for await pair in combineLatest(plain.entries,
                          filled.entries) {
      entryPairs.append(EntryPair(pair))
    }
  }
}

