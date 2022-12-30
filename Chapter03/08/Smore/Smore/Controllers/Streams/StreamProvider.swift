class StreamProvider {
  static var shared = StreamProvider()
  private var continuation: AsyncThrowingStream<Entry, Error>
                                 .Continuation?

  private(set) var count = 0 {
    didSet {
      if count.isMultiple(of: 5) {
        continuation?
          .yield(with: .failure(MultipleOfFiveError(number: count)))
      }
      continuation?.yield(Entry(number: count))
    }
  }
  
  func selectNextNumber() {
    count = (count + 1) % 51
  }
}

extension StreamProvider {
  var entryStream: AsyncThrowingStream<Entry, Error> {
    AsyncThrowingStream(Entry.self) { continuation in
      self.continuation = continuation
      continuation.onTermination = {@Sendable termination in
        print("Stream status:", termination)
      }
    }
  }
}

