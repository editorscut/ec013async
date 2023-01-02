import Foundation

struct EntryPair: Identifiable {
  let id = UUID()
  let plainEntry: Entry
  let filledEntry: Entry
}

extension EntryPair {
  init(_ first: Entry,
       _ second: Entry) {
    self.plainEntry = first
    self.filledEntry = second
  }
  init(_ number1: Int, _ number2: Int){
    self.plainEntry = Entry(number: number1)
    self.filledEntry = Entry(number: number2,
                             isFilled: true)
  }
}
