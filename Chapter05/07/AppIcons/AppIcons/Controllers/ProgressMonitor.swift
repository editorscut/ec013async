@globalActor
actor ProgressMonitor {
  static let shared = ProgressMonitor()
  private(set) var downloaded = 0
}


extension ProgressMonitor {
  @discardableResult
  func registerImageDownload() -> Int {
    downloaded += 1
    return downloaded
  }
}
