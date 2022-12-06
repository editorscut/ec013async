import Foundation

struct Entry: Identifiable {
  let id = UUID()
  let imageName: String
}

extension Entry {
  static var errorEntry: Entry {
    Entry(imageName: "circle.slash")
  }
}

extension Entry: Equatable {
  static func == (lhs: Entry, rhs: Entry) -> Bool {
    lhs.imageName == rhs.imageName
  }
}

extension Entry {
  static var exampleEntry: Entry {
    Entry(imageName: "1.circle")
  }
  static var exampleEntries: [Entry] {
    [Entry(imageName: "1.circle"),
    Entry(imageName: "2.circle"),
    Entry(imageName: "3.circle"),
    Entry(imageName: "4.circle"),
    Entry.errorEntry]
  }
}



