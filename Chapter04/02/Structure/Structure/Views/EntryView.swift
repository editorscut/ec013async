import SwiftUI

struct EntryView {
  let entry: Entry?
}

extension EntryView: View {
    var body: some View {
      if let entry {
        Image(systemName: entry.imageName)
          .font(.largeTitle)
          .padding()
      } else {
        ProgressView()
          .font(.largeTitle)
          .progressViewStyle(.circular)
      }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
      EntryView(entry: Entry.exampleEntry)
    }
}
