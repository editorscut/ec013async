import SwiftUI

struct IconView {
  let image: UIImage?
}

extension IconView: View {
  var body: some View {
    if let image {
      Image(uiImage: image)
        .resizable()
        .scaledToFit()
    } else {
      ZStack {
        Image(systemName: "square.fill")
          .resizable()
          .scaledToFit()
          .foregroundColor(.secondary.opacity(0.2))
        ProgressView()
          .progressViewStyle(.circular)
      }
    }
  }
}

struct IconView_Previews: PreviewProvider {
  static var previews: some View {
    IconView(image: nil)
  }
}
