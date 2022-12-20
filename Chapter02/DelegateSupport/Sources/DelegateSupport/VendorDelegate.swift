public protocol VendorDelegate: AnyObject {
  func vendorWillSelect(_ vendor: DelegatingVendor)
  func vendor(_ vendor: DelegatingVendor,
              didSelect number: Int)
}
