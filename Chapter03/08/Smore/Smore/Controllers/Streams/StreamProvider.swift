class StreamProvider {
  static let shared = StreamProvider()
  private var continuation: AsyncThrowingStream<Entry,
                                                Error>.Continuation?
  private init() {}
  
  private(set) var count = 0
  
  lazy private(set) var entries =
  AsyncThrowingStream(Entry.self) { continuation in
    self.continuation = continuation
    self.continuation?.onTermination = { @Sendable termination in
      print("Stream status:", termination)
    }
  }
  
  func selectNextNumber() {
    count = (count + 1) % 51
    if count.isMultiple(of: 5) {
      continuation?
        .yield(with: .failure(MultipleOfFiveError(number: count)))
    }
    continuation?.yield(Entry(number: count))
  }
}
