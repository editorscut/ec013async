import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
}

extension EntryController {
  func next() {
  }
}

extension EntryController {
  func vendorWillSelect() {
    isUpdating = true
  }
  
  func vendor(didSelect number: Int,
              isGreater: Bool) {
    entry = Entry(imageName: number.description + suffix)
    delta = isGreater ? "+" : "-"
    isUpdating = false
  }
}
