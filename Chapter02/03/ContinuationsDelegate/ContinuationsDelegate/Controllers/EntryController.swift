import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
  private let wrapper = DelegateWrapper()
}

extension EntryController {
  func next() {
    Task {
      await wrapper.requestRandomEntryNumber()
      isUpdating = true
      let (number, delta) = await wrapper.receiveRandomEntryNumber()
      entry = Entry(imageName: number.description + suffix)
      self.delta = delta.description
      isUpdating = false
    }
  }
}
