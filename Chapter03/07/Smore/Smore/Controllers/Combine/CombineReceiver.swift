import Foundation

class CombineReceiver {
  let entries
  = AsyncSequenceOfEntries(from: IntPublisher.shared.$count)
}
