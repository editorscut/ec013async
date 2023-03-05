import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry: Entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
  private let wrapper = ClosureWrapper()
}

extension EntryController {
  func next() {
    guard !isUpdating else { return }
    isUpdating = true
    Task {
      let (number, isGreater) = await wrapper.randomNumber()
      entry = Entry(imageName: number.description + suffix)
      delta = isGreater ? "+" : "-"
      isUpdating = false
    }
  }
}
