class StreamProvider {
  static let shared = StreamProvider()
  private init() {}
  
  private(set) var count = 0
  
  func selectNextNumber() {
    count = (count + 1) % 51
  }
}
