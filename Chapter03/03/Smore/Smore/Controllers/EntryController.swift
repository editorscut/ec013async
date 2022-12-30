import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  private let receiver = NotificationReceiver()
  
  init() {
    Task {
      await listenForNumbers()
    }
  }
}

extension EntryController {
  private func listenForNumbers() async {
    for await notification in receiver.notifications {
      // entries.append(Entry(number: number))
      print(notification)
    }
  }
}

extension EntryController {
  func nextEntry() {
    NotificationPoster.shared.selectNextNumber()
  }
}
