import SwiftUI

struct ContentView {
  @StateObject var vm = ViewModel()
}

extension ContentView: View {
    var body: some View {
      Text(vm.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
