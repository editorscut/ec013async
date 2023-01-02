import Foundation

struct Entry: Identifiable {
  let id = UUID()
  let imageName: String
}

extension Entry {
  init(number: Int,
       isFilled: Bool = false) {
    imageName = number.description + ".circle"
    + (isFilled ? ".fill" : "")
  }
}

extension Entry: Equatable, Comparable {
  static func < (lhs: Entry, rhs: Entry) -> Bool {
    lhs.numberPart < rhs.numberPart
  }
  
  static func == (lhs: Entry, rhs: Entry) -> Bool {
    lhs.numberPart == rhs.numberPart
  }
  
  var numberPart: Int {
    if let dot = self.imageName.firstIndex(of: "."),
       let int = Int(String(self.imageName[..<dot])) {
      return int
    } else {
      return 0
    }
  }
}

extension Entry {
  static var exampleEntry: Entry {
    Entry(imageName: "1.circle")
  }
}



