import Foundation

class NotificationReceiver {
  static let shared = NotificationReceiver()
  private init() {}
  
  let entries
  = NotificationCenter.default
    .notifications(named: NextNumberNotification.name)    .compactMap(\.userInfo)
    .compactMap { userInfo in
      userInfo[NextNumberNotification.numberKey] as? Int
    }
    .map { number in Entry(number: number)}
}
