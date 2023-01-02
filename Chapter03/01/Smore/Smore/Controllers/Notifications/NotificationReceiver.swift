import Foundation

class NotificationReceiver {
  func receiveNumbers(with completion: @escaping (Int) -> Void) {
    NotificationCenter
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
