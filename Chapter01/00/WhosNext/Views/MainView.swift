import SwiftUI

struct MainView {
}

extension MainView: View {
  var body: some View {
    NavigationStack {
      VStack {
        Text("View goes here")
      }
      .padding()
      .navigationTitle("Entries")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
