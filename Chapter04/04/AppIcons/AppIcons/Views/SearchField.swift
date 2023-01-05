import SwiftUI

struct SearchField {
  let search: (String) -> Void
  @State private var searchTerm = ""
}

extension SearchField: View {
  var body: some View {
    TextField("Enter Search Term",
              text: $searchTerm)
    .onSubmit {
      search(searchTerm)
    }
    .multilineTextAlignment(.center)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding()
  }
}

struct SearchField_Previews: PreviewProvider {
  static var previews: some View {
    SearchField(search: {_ in})
  }
}
