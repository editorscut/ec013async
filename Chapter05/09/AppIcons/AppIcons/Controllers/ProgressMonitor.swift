@globalActor
actor ProgressMonitor {
  static let shared = ProgressMonitor()
  var downloaded = 0
}


extension ProgressMonitor {
  @discardableResult
  func registerImageDownload() -> Int {
    downloaded += 1
    print(Tracker.appName, "is", downloaded,
          "of", Tracker.totalImages.description,
          "in", Tracker.searchTerm, "search")
    return downloaded
  }
  
  func reset() {
    downloaded = 0
  }
}
