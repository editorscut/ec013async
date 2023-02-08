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
  }
  
  func registerImageDownload(for appName: String)  {
    downloaded += 1
    print(downloaded, "/", total, "-", appName)
  }
}
