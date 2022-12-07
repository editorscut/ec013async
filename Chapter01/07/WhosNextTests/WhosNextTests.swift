import XCTest
@testable import WhosNext

final class WhosNextTests: XCTestCase {
  let vendor = AsyncEntryVendor()
  let entry3 = Entry(imageName: "3.circle")
  
  func testEntryCreation() async throws {
    let result = await vendor.entry(for: 203)
    XCTAssertEqual(result, entry3)
  }
  
  func testErrorEntryCreation() async throws {
    let result = await vendor.entry(for: 5)
    XCTAssertEqual(result, errorEntry())
  }
  
  func testImageNameCreatesEntry() async throws {
    do {
      let result = try await vendor.imageName(for: 53)
      XCTAssertEqual(result, entry3.imageName)
    } catch {
      XCTAssertFalse(true, error.localizedDescription)
    }
  }
  
  func testImageNameCreatesError() async throws {
    do {
      let _ = try await vendor.imageName(for: 5)
      XCTAssertTrue(false, "Expected MultipleOfFiveError")
    } catch {
      XCTAssertTrue(true, error.localizedDescription)
    }
  }
}
