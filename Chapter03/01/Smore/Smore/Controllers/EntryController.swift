import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entries: [Entry] = []
  private let receiver = NotificationReceiver.shared
  
  init() {
    receiver.receiveNumbers { number in
      self.entries.append(Entry(number: number))
    }
  }
}

extension EntryController {
  func nextEntry() {
    NotificationPoster.shared.selectNextNumber()
  }
}
