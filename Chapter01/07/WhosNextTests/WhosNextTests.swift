import XCTest
@testable import WhosNext

final class WhosNextTests: XCTestCase {
  let vendor = AsyncEntryVendor()
  let entry3 = Entry(imageName: "3.circle")
  
  func testEntryCreation() async {
    let result = await vendor.entry(for: 203)
    XCTAssertEqual(result, entry3)
  }
  
  func testErrorEntryCreation() async {
    let result = await vendor.entry(for: 5)
    XCTAssertEqual(result, errorEntry())
  }
  
  func testImageNameCreatesEntry() async {
    do {
      let result = try await vendor.imageName(for: 53)
      XCTAssertEqual(result, entry3.imageName)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testImageNameCreatesError() async {
    do {
      let _ = try await vendor.imageName(for: 5)
      XCTFail("Expected MultipleOfFiveError")
    } catch {
      XCTAssertEqual(error is MultipleOfFiveError, true)
    }
  }
}
