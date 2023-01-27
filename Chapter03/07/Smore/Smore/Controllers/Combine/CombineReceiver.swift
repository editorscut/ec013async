import Foundation

class CombineReceiver {
  static let shared = CombineReceiver()
  private init() {}
  
  let entries
  = AsyncSequenceOfEntries(from: IntPublisher.shared.$count)
}
