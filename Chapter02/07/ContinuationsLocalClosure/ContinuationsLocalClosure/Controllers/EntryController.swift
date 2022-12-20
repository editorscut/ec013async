import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
  private let vendor = ClosureBasedVendor()
}

extension EntryController {
  func next() {
    isUpdating = true
    Task {
      let (number, isGreater) = await vendor.selectRandomNumber()
      self.entry = Entry(imageName: number.description + self.suffix)
      self.delta = isGreater ? "+" : "-"
      self.isUpdating = false
    }
  }
}

