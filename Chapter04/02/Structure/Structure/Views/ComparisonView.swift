
import SwiftUI

struct ComparisonView {
  let comparison: Comparison?
}

extension ComparisonView: View {
    var body: some View {
      if let comparison {
        Image(systemName: comparison.imageName)
          .font(.largeTitle)
          .padding()
      } else {
        ProgressView()
          .font(.largeTitle)
          .progressViewStyle(.circular)
          .padding()
      }
    }
}


struct ComparisonView_Previews: PreviewProvider {
    static var previews: some View {
        ComparisonView(comparison: nil)
    }
}
