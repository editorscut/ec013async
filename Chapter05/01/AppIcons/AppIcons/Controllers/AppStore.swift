import Foundation
import Combine
import UIKit.UIImage

@MainActor
class AppStore: ObservableObject {
  @Published private(set) var apps = [AppInfo]()
  @Published private(set) var images = [String: UIImage]()
  private var downloadTask: Task<Void, Never>?
}

extension AppStore {
  func search(for rawText: String)  {
    resetForNextSearch()
    downloadTask = Task {
      do {
        apps
        = try await retrieveApps(for: rawText)
        print(apps)
        try await retrieveImages()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

extension AppStore {
  nonisolated
  private func retrieveApps(for rawText: String)
  async throws -> [AppInfo] {
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
  nonisolated
  private func retrieveImages() async throws {
    try await withThrowingTaskGroup(of: (UIImage?,
                                     String).self) { group in
      for app in await apps {
        group.addTask {
          async let (imageData, _)
          = try await ephemeralURLSession
            .data(from: app.artworkURL)
          let image = UIImage(data: try await imageData)
          return (image, app.name)
        }
      }
      for try await (image, name) in group {
        await publish(image: image,
                      forAppNamed: name)
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

extension AppStore {
  private func resetForNextSearch() {
    downloadTask?.cancel()
    apps.removeAll()
    images.removeAll()
  }
}

