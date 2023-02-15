import Distributed

distributed actor SimpleActor {
  typealias ActorSystem = LocalTestingDistributedActorSystem
  
  let name: String
  let vm: ViewModel
  
  init(name: String,
       vm: ViewModel,
       actorSystem: ActorSystem) {
    self.name = name
    self.vm = vm
    self.actorSystem = actorSystem
  }
}

