import Foundation
import ClosureSupport

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
  private let wrapper = ClosureWrapper()
}

extension EntryController {
  func next() {
    isUpdating = true
    Task {
      let (number, isGreater) = await wrapper.randomNumber()
      self.entry = Entry(imageName: number.description + self.suffix)
      self.delta = isGreater ? "+" : "-"
      self.isUpdating = false
    }
  }
}

