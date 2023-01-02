import SwiftUI

struct MainView {
  @StateObject private var controller = EntryController()
}

extension MainView: View {
  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        HStack {
          Spacer()
          EntryView(entry: controller.plainEntry)
          Spacer()
          ComparisonView(comparison: controller.comparison)
          Spacer()
          EntryView(entry: controller.filledEntry)
          Spacer()
        }
        
        Spacer()
        NextButton(controller: controller)
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
