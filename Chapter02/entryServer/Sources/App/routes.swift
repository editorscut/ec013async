import Vapor

func routes(_ app: Application) throws {
  app.get { req async in
    "It works!"
  }
  
  app.get("hello") { req -> String in
    "Hello, world!"
  }
  app.get("number") { req -> String in
    number()
  }
  
  app.get("imageName") { (request) -> String in
    imageName()
  }
  app.get("imageName", "filled") { (request) -> String in
    imageNameFilled()
  }
  app.get("entry") { (request) -> Entry in
     Entry(imageName: imageName())
  }
  app.get("entry", "filled") { (request) -> Entry in
    Entry(imageName: imageNameFilled())
  }
}

fileprivate func number() -> String {
  Int.random(in: 1...50).description
}

fileprivate func imageName() -> String {
  number() + ".circle"
}

fileprivate func imageNameFilled() -> String {
  imageName() + ".fill"
}

fileprivate struct EntryWrapper: Content {
  let entry: Entry
}
