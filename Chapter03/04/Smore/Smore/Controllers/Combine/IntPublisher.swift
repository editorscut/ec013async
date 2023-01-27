import Combine

class IntPublisher {
  static let shared = IntPublisher()
  private init() {}
  
  private(set) var count = 0

  func selectNextNumber() {
    count = (count + 1) % 51
  }
}
