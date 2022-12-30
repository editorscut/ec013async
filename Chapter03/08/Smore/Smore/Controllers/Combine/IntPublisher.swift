import Combine

class IntPublisher {
  static var shared = IntPublisher()
  @Published private(set) var count = 0

  func selectNextNumber() {
    count = (count + 1) % 51
  }
}
