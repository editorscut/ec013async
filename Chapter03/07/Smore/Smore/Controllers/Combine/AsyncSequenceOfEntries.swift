import Combine

class AsyncSequenceOfEntries {
  private let intPublisher: Published<Int>.Publisher
  
  init(from intPublisher: Published<Int>.Publisher) {
    self.intPublisher = intPublisher
  }
}

extension AsyncSequenceOfEntries: AsyncSequence {
  typealias AsyncIterator
  = AsyncMapSequence<
    AsyncDropFirstSequence<
      AsyncPublisher<
        Published<Int>.Publisher>>,
      Entry>.Iterator
  
  typealias Element = Entry
  
  func makeAsyncIterator() -> AsyncIterator {
    intPublisher
      .values
      .dropFirst()
      .map { number in Entry(number: number)}
      .makeAsyncIterator()
  }
}
