import Foundation

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry: Entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
  private let wrapper = DelegateWrapper()
}

extension EntryController {
  func next() {
    Task {
      let number = await wrapper.randomEntryNumber()
      entry = Entry(imageName: number.description + suffix)
    }
  }
}

extension EntryController {
  func vendorWillSelect() {
    isUpdating = true
  }
  
  func vendorDidSelect(number: Int) {
//    delta = vendor.delta.description
    isUpdating = false
  }
}
