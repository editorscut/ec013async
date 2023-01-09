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
        let plainTask = Task {
          try await plain.randomNumber()
        }
        let filledTask = Task {
          try await filled.randomNumber()
        }
        comparison = Comparison(try await plainTask.value,
                                try await filledTask.value)
        plainEntry = Entry(number: try await plainTask.value)
        filledEntry = Entry(number: try await filledTask.value,
                            isFilled: true)
      } catch {
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
