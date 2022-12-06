import SwiftUI

struct MainView {
  @StateObject private var controller = EntryController()
}

extension MainView: View {
  var body: some View {
    VStack(spacing: 60) {
      Spacer()
      Image(systemName: controller.entry.imageName)
        .font(.largeTitle)
        .foregroundColor(imageColor)
      Text("Disl")
        .foregroundColor(.secondary)
      Spacer()
      Button("Next"){ controller.next() }
        .disabled(controller.isUpdating)
      Spacer()
    }
  }
}

extension MainView {
  private var imageColor: Color {
    switch (controller.isUpdating, controller.entry.representsError) {
    case (true, _):
      return .secondary
    case (false, true):
      return .red
    case (false, false):
      return .primary
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
