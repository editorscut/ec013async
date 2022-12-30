import Foundation

class NotificationPoster {
  static let shared = NotificationPoster()
  private var count = 0 {
    didSet {
      NotificationCenter
        .default
        .post(name: NextNumberNotification.name,
              object: nil,
              userInfo: [NextNumberNotification.numberKey: count])
    }
  }
  
  func selectNextNumber() {
    count = (count + 1) % 51
  }
}
