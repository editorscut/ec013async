import Combine

class EntryController: ObservableObject {
  @Published private(set) var plainEntry: Entry?
  @Published private(set) var filledEntry: Entry?
  @Published private(set) var comparison: Comparison?
}

extension EntryController {
  func nextPair() {
  }
}

