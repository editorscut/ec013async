import Foundation
import DelegateSupport

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var entry = blankEntry()
  @Published private(set) var isUpdating = false
  @Published private(set) var delta = "..."
  let suffix = ".circle"
  lazy private var numberVendor
    = DelegatingVendor(delegate: self)
}

extension EntryController {
  func next() {
    numberVendor.selectRandomNumber()
  }
}

extension EntryController: VendorDelegate {
  func vendorWillSelect(_ vendor: DelegatingVendor) {
    isUpdating = true
  }
  
  func vendor(_ vendor: DelegatingVendor,
              didSelect number: Int) {
    entry = Entry(imageName: number.description + suffix)
    delta = vendor.delta.description
    isUpdating = false
  }
}
