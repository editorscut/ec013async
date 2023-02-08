@globalActor
actor ProgressMonitor {
  static let shared = ProgressMonitor()
  private(set) var searchTerm = ""
  private(set) var total = 0
  private(set) var downloaded = 0
}


extension ProgressMonitor {
  func reset(total: Int,
             for searchTerm: String) {
    self.total = total
    downloaded = 0
    self.searchTerm = searchTerm
  }

  func registerImageDownload(for appName: String) {
    downloaded += 1
  }
}
