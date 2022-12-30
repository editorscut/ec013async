class StreamProvider {
  static var shared = StreamProvider()
  private(set) var count = 0
  
  func selectNextNumber() {
    count = (count + 1) % 51
  }
}



