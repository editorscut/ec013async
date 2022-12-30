import Foundation

enum NextNumberNotification {}

extension NextNumberNotification {
  
  public static var name = Notification.Name("nextNumberNotification")
  
  public static var numberKey
  = "NextNumberNotificationUserInfoDictionaryNumberKey"
}
