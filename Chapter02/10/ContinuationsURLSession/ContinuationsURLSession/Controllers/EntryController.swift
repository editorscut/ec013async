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
    Task {
      do {
        let number = try await vendor.randomNumber()
        self.entry = Entry(imageName: number.description + self.suffix)
      } catch {
        self.entry = errorEntry()
      }
      self.isUpdating = false
    }
  }
}

