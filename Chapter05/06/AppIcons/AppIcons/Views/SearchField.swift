import SwiftUI

struct SearchField {
  let appStore: AppStore
  @Binding var searchTerm: String
}

extension SearchField: View {
  var body: some View {
    TextField("Enter Search Term",
              text: $searchTerm)
    .onSubmit {
      appStore.search(for: searchTerm)
    }
    .multilineTextAlignment(.center)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding()
  }
}

struct SearchField_Previews: PreviewProvider {
  static var previews: some View {
    SearchField(appStore: AppStore(),
                searchTerm: .constant(""))
  }
}
