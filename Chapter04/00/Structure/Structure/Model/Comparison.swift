enum Comparison {
  case greater
  case lesser
  case equal
  
  init(_ first: Entry,
       _ second: Entry) {
    self.init(first.numberPart,
              second.numberPart)
  }
  
  init(_ first: Int,
       _ second: Int) {
    if first == second {
      self = .equal
    } else if first < second {
      self = .lesser
    } else  {
      self = .greater
    }
  }
}

extension Comparison {
  var imageName: String {
    switch self {
    case .greater: return "arrow.left"
    case .lesser: return "arrow.right"
    default: return "minus"
    }
  }
}
