class AutoEntryVendor {
  let delay: Double
  let isFilled: Bool
  private var count = 0
  
  init(delay: Double,
       isFilled: Bool = false) {
    self.delay = delay
    self.isFilled = isFilled
  }
  
  lazy private(set) var entries
  = AsyncStream(Entry.self) { continuation in
    Task {
      while count < 10 {
        count += 1
        try? await Task.sleep(for: .seconds(delay))
        continuation.yield(Entry(number: count,
                                 isFilled: isFilled))
      }
      continuation.finish()
    }
  }
}


