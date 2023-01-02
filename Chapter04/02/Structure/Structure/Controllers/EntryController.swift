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
      async let plainNumber = plain.randomNumber()
      async let filledNumber = filled.randomNumber()
      comparison = Comparison(await plainNumber,
                              await filledNumber)
      plainEntry = Entry(number: await plainNumber)
      filledEntry = Entry(number: await filledNumber,
                          isFilled: true)
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
