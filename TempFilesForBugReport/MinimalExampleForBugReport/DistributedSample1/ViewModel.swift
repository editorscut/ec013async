import Combine
import Distributed

class ViewModel: ObservableObject {
  @Published var name: String = ""
  private var simpleActor: SimpleActor?
  
  init() {
   simpleActor = SimpleActor(name: "Sample",
                             vm: self,
                             actorSystem: LocalTestingDistributedActorSystem())
    self.name = "Sample"
  }
}
