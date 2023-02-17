import SwiftUI
import BonjourDemoActorSystem

let bonjourActorSystem = SampleLocalNetworkActorSystem()

@main
struct AppIconsApp: App {
  var body: some Scene {
    WindowGroup {
      MainView()
    }
  }
}
