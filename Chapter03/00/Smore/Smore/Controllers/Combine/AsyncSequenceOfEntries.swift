import Combine

class AsyncSequenceOfEntries {
  private let intPublisher: Published<Int>.Publisher
  
  init(from intPublisher: Published<Int>.Publisher) {
    self.intPublisher = intPublisher
  }
}
