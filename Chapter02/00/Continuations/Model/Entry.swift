struct Entry: Codable {
  let imageName: String
}

extension Entry {
  var representsError: Bool {
    imageName == "circle.slash"
  }
  static var errorEntry: Entry {
    Entry(imageName: "circle.slash")
  }
  static var blankEntry: Entry {
    Entry(imageName: "circle.dotted")
  }
}

extension Entry {
  static var exampleEntry: Entry {
    Entry(imageName: "1.circle")
  }
  static var exampleEntries: [Entry] {
    [Entry(imageName: "1.circle"),
    Entry(imageName: "2.circle"),
    Entry(imageName: "3.circle")]
  }
}


