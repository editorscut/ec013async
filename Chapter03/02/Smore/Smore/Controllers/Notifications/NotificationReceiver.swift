import Foundation

class NotificationReceiver {
  static let shared = NotificationReceiver()
  private var token: Any?
  private init() {}
  deinit {
    if let token {
      NotificationCenter.default.removeObserver(token)
    }
  }
  
  lazy private(set) var numbers
  = AsyncStream<Int> { continuation in
    token = NotificationCenter.default
      .addObserver(forName: NextNumberNotification.name,
                   object: NotificationPoster.shared,
                   queue: nil) { notification in
        if let userInfo = notification.userInfo,
           let number = userInfo[NextNumberNotification.numberKey]
            as? Int {
          continuation.yield(number)
        }
      }
  }
}
