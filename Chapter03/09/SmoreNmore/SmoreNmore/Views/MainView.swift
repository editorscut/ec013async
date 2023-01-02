import SwiftUI

struct MainView {
  @StateObject private var controller = EntryController()
}

extension MainView: View {
  var body: some View {
    NavigationStack {
      VStack {
        EntryPairGrid(entryPairs: controller.entryPairs)
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
