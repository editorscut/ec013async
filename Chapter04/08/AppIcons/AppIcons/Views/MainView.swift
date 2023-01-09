import SwiftUI

struct MainView {
  @State private var apps = [AppInfo]()
}

extension MainView: View {
  var body: some View {
    VStack {
      SearchField(apps: $apps)
      AsyncImageGrid(apps: apps)
    }
    .padding()
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}


