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
    guard !isUpdating else { return }
    isUpdating = true
    Task {
      let (number, isGreater) = await vendor.randomNumber()
      entry = Entry(imageName: number.description + suffix)
      delta = isGreater ? "+" : "-"
      isUpdating = false
    }
  }
}
