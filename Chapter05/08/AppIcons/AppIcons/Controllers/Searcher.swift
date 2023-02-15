import Distributed

distributed actor Searcher {
  typealias ActorSystem = LocalTestingDistributedActorSystem
  let name: String
  let appStore: AppStore
  
  init(name: String,
       appStore: AppStore,
       actorSystem: ActorSystem) {
    self.name = name
    self.appStore = appStore
    // this should be self.actorSystem = actorSystem but I get a crash and don't know why
//    self.actorSystem = LocalTestingDistributedActorSystem()
    self.actorSystem = actorSystem
  }
}

extension Searcher {
  distributed func search(for searchTerm: String) async throws {
    for otherSearcher in await appStore.otherSearchers {
      try await otherSearcher.receive(searchTerm,
                                      from: name)
    }
  }
  
  distributed func receive(_ searchTerm: String,
                           from searcherName: String)  async throws {
    // update our list of current searches
  }
}
