import Foundation

class NotificationReceiver {
  var numbers: AsyncStream<Int> {
    AsyncStream(Int.self) { continuation in
      NotificationCenter
        .default
        .addObserver(forName: NextNumberNotification.name,
                     object: nil,
                     queue: nil) { notification in
          if let userInfo = notification.userInfo,
             let number = userInfo[NextNumberNotification.numberKey]
              as? Int {
            continuation.yield(number)
          }
        }
    }
  }
}
