import Foundation
import Vapor

struct Entry: Codable, Content {
  let imageName : String
  
  init(imageName: String = "circle.slash" ) {
    self.imageName = imageName
  }
}


