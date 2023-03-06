import Foundation

enum NextNumberNotification {}

extension NextNumberNotification {
  
  public static let name = Notification.Name("nextNumberNotification")
  
  public static let numberKey
  = "NextNumberNotificationUserInfoDictionaryNumberKey"
}
