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
      let number = await wrapper.randomNumber()
      entry = Entry(imageName: number.description + suffix)
    }
  }
}

extension EntryController {
  func vendorWillSelect() {
    isUpdating = true
  }
  
  func vendor(didSelect number: Int) {
    entry = Entry(imageName: number.description + suffix)
//    delta = vendor.delta.description
    isUpdating = false
  }
}
