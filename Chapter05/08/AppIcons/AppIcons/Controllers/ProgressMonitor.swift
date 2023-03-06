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
    print("resetting to search for:", Tracker.searchTerm)
  }
  
  @discardableResult
  func registerImageDownload() -> Int {
    downloaded += 1
    print(Tracker.appName, "is", downloaded,
          "of", Tracker.totalImages.description,
              "in", Tracker.searchTerm, "search")
    return downloaded
  }
}
