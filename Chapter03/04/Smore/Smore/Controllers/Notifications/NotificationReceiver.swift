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
      for await notification in notifications {
        if let userInfo = notification.userInfo,
           let number = userInfo[NextNumberNotification.numberKey]
            as? Int {
          continuation.yield(Entry(number: number))
        }
      }
    }
  }
}
