import SwiftUI

struct NextButton {
  let controller: EntryController
}

extension NextButton: View {
  var body: some View {
    Button("Next") {
      controller.nextEntry()
    }
  }
}
