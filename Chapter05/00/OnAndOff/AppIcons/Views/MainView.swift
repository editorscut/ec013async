import SwiftUI

struct MainView {
  @StateObject private var appStore = AppStore()
  @State private var searchTerm = ""
}

extension MainView: View {
  var body: some View {
    VStack {
      SearchField(appStore: appStore,
      searchTerm: $searchTerm)
      IconGrid(appStore: appStore)
    }
    .padding()
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}


