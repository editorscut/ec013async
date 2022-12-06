public protocol VendorDelegate {
  func vendorWillSelect(_ vendor: VendorUsingDelegates)
  func vendorDidSelect(_ vendor: VendorUsingDelegates,
                       number: Int)
}
