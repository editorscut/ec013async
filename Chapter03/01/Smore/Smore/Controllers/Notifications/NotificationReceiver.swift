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
  
  func receiveNumbers(with completion: @escaping (Int) -> Void) {
    token = NotificationCenter
      .default
      .addObserver(forName: NextNumberNotification.name,
                   object: nil,
                   queue: nil) { notification in
        if let userInfo = notification.userInfo,
           let number = userInfo[NextNumberNotification.numberKey]
            as? Int {
          completion(number)
        }
      }
  }
}
