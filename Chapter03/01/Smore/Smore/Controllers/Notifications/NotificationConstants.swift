import Foundation

enum NextNumberNotification {}

extension NextNumberNotification {
  static var name = Notification.Name("nextNumberNotification")
  static var numberKey
  = "NextNumberNotificationUserInfoDictionaryNumberKey"
}
