import Foundation

@globalActor
actor ProgressMonitor {
  static let shared = ProgressMonitor()
  private(set) var downloaded = 0
  
  private init() {}
}

extension ProgressMonitor {
  func reset() {
    downloaded = 0
  }
  
  @discardableResult
  func registerImageDownload() -> Int {
    downloaded += 1
    return downloaded
  }
}
