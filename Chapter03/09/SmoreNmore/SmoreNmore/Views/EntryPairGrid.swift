import SwiftUI

struct EntryPairGrid {
  let entryPairs: [EntryPair]
  private let columns = [GridItem(.adaptive(minimum: 100,
                                            maximum: 100))]
}

extension EntryPairGrid: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach (entryPairs) {pair in
          HStack {
            Image(systemName: pair.plainEntry.imageName)
              .resizable()
              .scaledToFit()
              .foregroundColor(pair.plainEntry == errorEntry()
                               ? .red
                               : .primary)
            Image(systemName: pair.filledEntry.imageName)
              .resizable()
              .scaledToFit()
              .foregroundColor(pair.filledEntry == errorEntry()
                               ? .red
                               : .primary)
          }
          .padding()
        }
      }
    }
    .padding()
  }
}

struct EntryPairGrid_Previews: PreviewProvider {
  static var previews: some View {
    EntryPairGrid(entryPairs: [EntryPair(3, 7)])
  }
}



