import SwiftUI

struct SearchField {
  @Binding var apps: [AppInfo]
  @State private var searchTerm = ""
}

extension SearchField: View {
  var body: some View {
    TextField("Enter Search Term",
              text: $searchTerm)
    .onSubmit {
      search()
    }
    .multilineTextAlignment(.center)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding()
  }
}

extension SearchField {
  private func search() {
    apps.removeAll()
    Task {
      do {
        let (data, _)
        = try await ephemeralURLSession
          .data(from: url(for: searchTerm))
        let searchResults
        = try JSONDecoder()
          .decode(SearchResults.self,
                  from: data)
        apps = searchResults.apps
      } catch {
        print(error)
      }
    }
  }
}

struct SearchField_Previews: PreviewProvider {
  static var previews: some View {
    SearchField(apps: .constant([AppInfo]()))
  }
}
