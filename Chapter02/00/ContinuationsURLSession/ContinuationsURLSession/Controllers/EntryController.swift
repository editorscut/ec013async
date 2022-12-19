import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry: Entry = blankEntry()
  @Published private(set) var isUpdating = false
  let suffix = ".circle"
  private let vendor = VendorUsingURLSession()
}

extension EntryController {
  func next() {
    isUpdating = true
    vendor.randomNumber { number in
      self.entry = Entry(imageName: number.description + self.suffix)
      self.isUpdating = false
    }
  }
}

