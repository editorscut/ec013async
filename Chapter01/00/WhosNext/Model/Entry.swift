import Foundation

struct Entry {
  let date = Date()
  let imageName: String
}

extension Entry: Hashable,  Identifiable {
  var id: Int  {
   hashValue
  }
}

extension Entry {
  var representsError: Bool {
    imageName == "circle.slash"
  }
  static var errorEntry: Entry {
    Entry(imageName: "circle.slash")
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



