import Foundation

class NotificationReceiver {
  static let shared = NotificationReceiver()
  private init() {}
  
  let notifications
  = NotificationCenter.default
    .notifications(named: NextNumberNotification.name)
  
  lazy private(set) var entries
  = AsyncStream(Entry.self) {continuation in
    Task {
      let asyncSequence
      = notifications
        .compactMap(\.userInfo)
        .compactMap { userInfo in
          userInfo[NextNumberNotification.numberKey] as? Int
        }
        .map { number in Entry(number: number)}
      
      for await entry in asyncSequence {
        continuation.yield(entry)
      }
    }
  }
}
