import Foundation

struct SleepingEntry  {
  func entry(for count: Int) -> Entry {
    let imageName = imageName(for: count)
    return Entry(imageName: imageName)
  }
}

extension SleepingEntry {
  private func imageName(for int: Int) -> String {
    let number = int % 50
    Thread.sleep(forTimeInterval: TimeInterval(secondsDelay))
    return "\(number).circle"
  }
}

extension SleepingEntry {
  private var secondsDelay:UInt32 {
    UInt32.random(in: 2...6)
  }
}
