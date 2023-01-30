import Combine

@MainActor
class EntryController: ObservableObject {
  @Published private(set) var plainEntry: Entry?
  @Published private(set) var filledEntry: Entry?
  @Published private(set) var comparison: Comparison?
  
  private let plain = NumberVendor(delay: 2.0)
  private let filled = NumberVendor(delay: 1.5)
  
  private var nextTask: Task<Void, Error>?
}

extension EntryController {
  func nextPair() {
    clear()
    nextTask = Task {
      do {
        async let plainNumber = plain.randomNumber()
        async let filledNumber = await filled.randomNumber()
        comparison = Comparison(try await plainNumber,
                                try await filledNumber)
        plainEntry = Entry(number: try await plainNumber)
        filledEntry = Entry(number: try await filledNumber,
                            isFilled: true)
      }
      catch {
        print(error)
      }
    }
  }
}

extension EntryController {
  private func clear() {
    nextTask?.cancel()
    plainEntry = nil
    filledEntry = nil
    comparison = nil
  }
}

