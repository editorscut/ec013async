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
    guard !isUpdating else {return}
    Task {
      await wrapper.requestRandomNumber()
      isUpdating = true
      let (number, delta)
      = await wrapper.receiveRandomNumber()
      entry = Entry(imageName: number.description + suffix)
      self.delta = delta.description
      isUpdating = false
    }
  }
}


