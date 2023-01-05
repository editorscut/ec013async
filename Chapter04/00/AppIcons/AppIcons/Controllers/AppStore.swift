import Foundation
import Combine
import UIKit.UIImage

class AppStore: ObservableObject {
  private(set) var apps = [AppInfo]()
  @Published private(set) var images = [String: UIImage]()
}

extension AppStore {
  func search(for rawText: String)  {
  }
}

extension AppStore {
  private func publish(image: UIImage?,
                       forAppNamed name: String) {
    if let image {
      images[name] = image
    }
  }
}
