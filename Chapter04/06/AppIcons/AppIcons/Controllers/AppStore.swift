import Foundation
import Combine
import UIKit.UIImage

@MainActor
class AppStore: ObservableObject {
  @Published private(set) var apps = [AppInfo]()
  @Published private(set) var images = [String: UIImage]()
}

extension AppStore {
  func search(for rawText: String) {
    Task {
      do {
        apps = try await retrieveApps(for: rawText)
        print(apps)
        try await retrieveImages()
      } catch {
        print(error)
      }
    }
  }
}

extension AppStore {
  private func retrieveApps(for rawText: String) async throws -> [AppInfo] {
    let (data, _)
    = try await ephemeralURLSession
      .data(from: url(for: rawText))
    let searchResults
    = try JSONDecoder().decode(SearchResults.self,
                               from: data)
    return searchResults.apps
  }
}

extension AppStore {
  private func retrieveImages() async throws {
    try await withThrowingTaskGroup(of: Void.self) { group in
      for app in apps {
        group.addTask {
          async let (imageData, _)
          = ephemeralURLSession
            .data(from: app.artworkURL)
          let image = UIImage(data: try await imageData)
          await self.publish(image: image,
                             forAppNamed: app.name)
        }
      }
    }
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
