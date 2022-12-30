import Foundation

class NotificationReceiver {  
  let entries
  = NotificationCenter.default
    .notifications(named: NextNumberNotification.name)
    .compactMap(\.userInfo)
    .compactMap { dictionary in
      dictionary[NextNumberNotification.numberKey] as? Int
    }
    .map {number in Entry(number: number)}
}

