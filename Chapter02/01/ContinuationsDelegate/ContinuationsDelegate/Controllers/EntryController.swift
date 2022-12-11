import Foundation
import DelegateSupport

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry: Entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
  lazy private var numberVendor
    = VendorUsingDelegates(delegate: self)
}

extension EntryController {
  func next() {
    numberVendor.randomNumber()
  }
}

extension EntryController: VendorDelegate {
  func vendorWillSelect(_ vendor: VendorUsingDelegates) {
    isUpdating = true
  }
  
  func vendorDidSelect(_ vendor: VendorUsingDelegates,
                       number: Int) {
    entry = Entry(imageName: number.description + suffix)
    delta = vendor.delta.description
    isUpdating = false
  }
}
