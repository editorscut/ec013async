import SwiftUI

struct AsyncImageGrid {
  let apps: [AppInfo]
  let columns = [GridItem(.adaptive(minimum: 60,
                                   maximum: 60))]
}

extension AsyncImageGrid: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
      }
    }
  }
}

struct AsyncImageGrid_Previews: PreviewProvider {
  static var previews: some View {
    AsyncImageGrid(apps: [AppInfo]())
  }
}
