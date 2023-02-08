import Foundation
import Combine
import UIKit.UIImage

@MainActor
class AppStore: ObservableObject {
  @Published private(set) var apps = [AppInfo]()
  @Published private(set) var images = [String: UIImage]()
  private var downloadTask: Task<Void, Never>?
  private var monitor: ProgressMonitor?
}

extension AppStore {
  func search(for rawText: String)  {
    resetForSearch(for: rawText)
    downloadTask = Task {
      do {
        apps = try await retrieveApps(for: rawText)
        await monitor?.reset(total: apps.count)
        try await retrieveImages()
        await monitor?.header()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

extension AppStore {
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
  private func retrieveImages() async throws {
    guard let monitor  else { return }
    try await withThrowingTaskGroup(of: (UIImage?,
                                     String).self) {group in
      for app in apps {
        group.addTask {
          async let (imageData, _)
          = try await ephemeralURLSession
            .data(from: app.artworkURL)
          let image = UIImage(data: try await imageData)
          await monitor.registerImageDownload(for: app.name)
          return (image, app.name)
        }
      }
      for try await (image, name) in group {
        publish(image: image,
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
  private func resetForSearch(for rawText: String) {
    downloadTask?.cancel()
    apps.removeAll()
    images.removeAll()
    monitor = ProgressMonitor(for: rawText)
  }
}
