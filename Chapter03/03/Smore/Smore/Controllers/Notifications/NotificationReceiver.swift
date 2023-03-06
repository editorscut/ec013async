import Foundation

class NotificationReceiver {
  static let shared = NotificationReceiver()
  private init() {}
  
  let notifications = NotificationCenter.default
    .notifications(named: NextNumberNotification.name,
                   object: NotificationPoster.shared)
  
  lazy private(set) var numbers
  = AsyncStream<Int> { continuation in
    Task {
      for await notification in notifications {
        if let userInfo = notification.userInfo,
           let number = userInfo[NextNumberNotification.numberKey]
            as? Int {
          continuation.yield(number)
        }
      }
    }
  }
}
