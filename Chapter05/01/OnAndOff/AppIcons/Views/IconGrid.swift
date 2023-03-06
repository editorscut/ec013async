import SwiftUI

struct IconGrid {
  @ObservedObject var appStore: AppStore
  let columns = [GridItem(.adaptive(minimum: 50,
                                   maximum: 50))]
}

extension IconGrid: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(appStore.apps) {appInfo in
          IconView(image: appStore.images[appInfo.name] )
        }
      }
    }
  }
}

struct IconGrid_Previews: PreviewProvider {
  static var previews: some View {
    IconGrid(appStore: AppStore())
  }
}
