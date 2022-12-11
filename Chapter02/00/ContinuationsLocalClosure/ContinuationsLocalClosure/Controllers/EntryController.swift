import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry: Entry = blankEntry()
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
  
  func vendorDidSelect(number: Int,
                       deltaNumber: Int) {
    entry = Entry(imageName: number.description + suffix)
    delta = deltaNumber.description
    isUpdating = false
  }
}
