import Foundation

enum NextNumberNotification {}

extension NextNumberNotification {
  static let name = Notification.Name("nextNumberNotification")
  static let numberKey
  = "NextNumberNotificationUserInfoDictionaryNumberKey"
}
