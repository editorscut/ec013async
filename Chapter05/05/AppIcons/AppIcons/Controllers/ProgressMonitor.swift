import Foundation

actor ProgressMonitor {
  let searchTerm: String
  private(set) var total = 0
  private(set) var downloaded = 0
  
  init(for searchTerm: String) {
    self.searchTerm = searchTerm
  }
}

extension ProgressMonitor {
  func reset(total: Int) {
    self.total = total
    downloaded = 0
    header()
  }
  
  func header() {
    Task {
      print("\n=========================\n", searchTerm,
            "has", total, "results")
      separator()
    }
  }
  
  nonisolated
  func separator() {
    print("=========================\n")
  }
  
  func registerImageDownload(for appName: String) {
    downloaded += 1
    status(for: appName)
  }
  
  func status(for appName: String) {
    print(downloaded, "/", total, "-", appName)
  }
}
