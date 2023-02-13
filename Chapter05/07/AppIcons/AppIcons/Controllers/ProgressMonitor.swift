@globalActor
actor ProgressMonitor {
  static let shared = ProgressMonitor()
  var downloaded = 0
}


extension ProgressMonitor {
  @discardableResult
  func registerImageDownload() -> Int {
    downloaded += 1
    return downloaded
  }
  
  func reset() {
    downloaded = 0
  }
}
