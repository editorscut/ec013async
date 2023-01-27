class ProgressMonitor {
  static var shared = ProgressMonitor()
  private(set) var total = 0
  private(set) var downloaded = 0
}

extension ProgressMonitor {
  func resetTotal(to numberOfApps: Int) {
    total = numberOfApps
    downloaded = 0
  }
  
  func registerCompletedDownload() {
    downloaded += 1
    print("Downloaded", downloaded, "/", total)
  }
}
