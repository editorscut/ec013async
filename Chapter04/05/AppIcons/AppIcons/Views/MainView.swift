import SwiftUI

struct MainView {
  @StateObject private var appStore = AppStore()
}

extension MainView: View {
  var body: some View {
    VStack {
      SearchField {term in appStore.search(for: term)}
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


