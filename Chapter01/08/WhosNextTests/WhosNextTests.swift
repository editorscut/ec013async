import XCTest
@testable import WhosNext

final class WhosNextTests: XCTestCase {
  let vendor = AsyncEntry()

  let entry3 = Entry(imageName: "3.circle")
  let errorEntry = Entry.errorEntry
  
  func testEntryCreation() async throws {
    let result = await vendor.entry(for: 3)
    XCTAssertEqual(result, entry3)
  }
  
  func testErrorEntryCreation() async throws {
    let result = await vendor.entry(for: 5)
    XCTAssertEqual(result, errorEntry)
  }
  
  func testImageNameForLargeValidInput() async throws {
    let result = try await vendor.imageName(for: 203)
    XCTAssertEqual(result, "3")
  }
  
  func testImageNameForMultipleOfFive() async throws {
    var throwsError: Bool
    do {
      _ = try await vendor.imageName(for: 5)
      throwsError = false
    } catch {
      throwsError = true
    }
    XCTAssertTrue(throwsError, "Multiple of 5 causes error to be thrown")
  }
}
