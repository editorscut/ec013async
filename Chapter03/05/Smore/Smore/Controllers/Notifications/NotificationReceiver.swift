import Foundation

class NotificationReceiver {
  let notifications
  = NotificationCenter.default
    .notifications(named: NextNumberNotification.name)
  
  var entries: AsyncStream<Entry> {
    AsyncStream(Entry.self) { continuation in
      Task {
        let asyncSequence
        = notifications
          .compactMap(\.userInfo)
          .compactMap { dictionary in
            dictionary[NextNumberNotification.numberKey] as? Int
          }
          .map {number in Entry(number: number)}
        
        for await entry in asyncSequence {
          continuation.yield(entry)
        }
      }
    }
  }
}

