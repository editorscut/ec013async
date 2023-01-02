import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var plainEntry: Entry?
  @Published private(set) var filledEntry: Entry?
  @Published private(set) var comparison: Comparison?
  
  private let plain = NumberVendor(delay: 2.0)
  private let filled = NumberVendor(delay: 1.5)
}

extension EntryController {
  func nextPair() {
    clear()
    Task {
      let plainNumber = await plain.randomNumber()
      plainEntry = Entry(number: plainNumber)
      let filledNumber = await filled.randomNumber()
      filledEntry = Entry(number: filledNumber,
                          isFilled: true)
      comparison = Comparison(plainNumber, filledNumber)
    }
  }
}

extension EntryController {
  private func clear() {
    plainEntry = nil
    filledEntry = nil
    comparison = nil
  }
}
