import Foundation

class NotificationReceiver {
  let notifications
  = NotificationCenter.default
    .notifications(named: NextNumberNotification.name)
  
  var entries: AsyncStream<Entry> {
    AsyncStream(Entry.self) { continuation in
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
}
