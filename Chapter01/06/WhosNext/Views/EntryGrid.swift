import SwiftUI

struct EntryGrid {
  let entries: [Entry]
  private let columns = [GridItem(.adaptive(minimum: 50,
                                            maximum: 80))]
}

extension EntryGrid: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach (entries) {entry in
          Image(systemName: entry.imageName)
            .resizable()
            .scaledToFit()
            .foregroundColor(entry == errorEntry() ? .red : .primary)
        }
      }
    }
  }
}

struct EntryGrid_Previews: PreviewProvider {
  static var previews: some View {
    EntryGrid(entries: Entry.exampleEntries)
  }
}
