/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Naive implementation of a receptionist which just keeps broadcasting about all checked-in actors. Good enough for demo purposes.
*/

import Distributed
import Foundation

@available(iOS 16.0, *)
public distributed actor LocalNetworkReceptionist: DistributedActorReceptionist {
    public typealias ActorSystem = SampleLocalNetworkActorSystem
    
    struct CheckInID: Hashable {
        let actorID: ActorSystem.ActorID
        let tag: String
    }
    
    var knownActors: [CheckInID: any DistributedActor] = [:]
    
    // Mapping of subscriptions to streams
    //
    // Note that this implementation is pretty naive, a better implementation would keep specific
    // streams for specific actor types subscribed to, as well as keep de-duplication implemented as part of the receptionist wire protocol.
    private var streams: [AsyncStream<any DistributedActor>.Continuation] = []
        
    public nonisolated func checkIn<Act>(_ actor: Act, tag: String) where Act: DistributedActor, Act: Codable, Act.ActorSystem == ActorSystem {
        Task {
            let applied: ()? = await self.whenLocal { __secretlyKnownToBeLocal in
                __secretlyKnownToBeLocal.localCheckIn(actor, tag: tag)
            }
            
            precondition(applied != nil, "checkIn must only be called on local receptionist references.")
        }
    }
    
    func localCheckIn<Act>(_ actor: Act, tag: String) where Act: DistributedActor, Act: Codable, Act.ActorSystem == ActorSystem {
        log("receptionist", "Checking in \(Act.self) with ID \(actor.id)")
        
        let cid = CheckInID(actorID: actor.id, tag: tag)
        if self.knownActors[cid] != nil {
            return // we know about it already
        }

        self.knownActors[cid] = actor
        self.inform(about: actor, tag: tag)
        
        // Tell all other receptionists about it.
        //
        // Rather naive implementation that does not take feedback from recipients,
        // a better implementation would negotiate with recipients and see which actors they are not aware of yet.
        // Note that such tasks should also be cancelled when the system shuts down.
        Task.detached {
            while true {
                precondition(self.id.id == "receptionist")
                
                let remoteID = self.id // due to special handling of receptionist ID resolving, this will resolve remote ones
                let remoteReceptionist = try Self.resolve(id: remoteID, using: self.actorSystem)
                log("receptionist", "Inform remote receptionist about [\(actor.id)]")
                try await remoteReceptionist.inform(about: actor, tag: tag)
                log("receptionist", "DONE INFORMING ABOUT \(actor.id)")
                
//                Thread.sleep(forTimeInterval: 1)
              try await Task.sleep(for: .seconds(1))
            }
        }
    }
    
    distributed func inform<Act>(about actor: Act, tag: String)
    where Act: DistributedActor, Act: Codable, Act.ActorSystem == SampleLocalNetworkActorSystem {
        let cid = CheckInID(actorID: actor.id, tag: tag)
        let actorDescription = "\(actor)(\(actor.id))"
        log("receptionist", "Receptionist received information about \(actorDescription)")
        if self.knownActors[cid] != nil {
            log("receptionist", "Already know about: \(actorDescription)")
            return // we know about it already
        }
        
        // store and publish it to our listing
        log("receptionist", "New actor, store and publish: \(actorDescription)")
        self.knownActors[cid] = actor
        for stream in streams {
            // A more advanced receptionist implementation would need to take
            // care of de-duplication here, so we don't emit the same ref twice.
            let result = stream.yield(actor)
            switch result {
            case .enqueued(let remaining):
                log("matchmaking-receptionist", "yield \(actor.id) (remaining: \(remaining))")
            case .dropped(let value):
                log("matchmaking-receptionist", "dropped \(value)")
            case .terminated:
                log("matchmaking-receptionist", "stream terminated, dropped \(actor.id)")
                return
            @unknown default:
                fatalError("Unknown: \(result)")
            }
        }
    }
    
    public nonisolated func listing<Act>(of type: Act.Type, tag: String, file: String = #file, line: Int = #line, function: String = #function) async
    -> AsyncCompactMapSequence<AsyncStream<any DistributedActor>, Act>
    where Act: DistributedActor, Act.ActorSystem == SampleLocalNetworkActorSystem {
        log("receptionist", "New listing request: \(Act.self) at \(file):\(line)(\(function))")
        let stream = await self.whenLocal { __secretlyKnownToBeLocal in
            __secretlyKnownToBeLocal.localListing(of: type, tag: tag)
        }
        guard let stream = stream else {
            preconditionFailure("\(#function) may only be invoked on local receptionist references")
        }
        return stream
    }
    
    func localListing<Act>(of type: Act.Type, tag: String)
            -> AsyncCompactMapSequence<AsyncStream<any DistributedActor>, Act>
            where Act: DistributedActor, Act.ActorSystem == SampleLocalNetworkActorSystem {
    let newStream: AsyncStream<any DistributedActor> = AsyncStream { continuation in
        self.streams.append(continuation)

        // Task also flush all already known actors to this stream
        for (key, actor) in knownActors where key.tag == tag {
            let result = continuation.yield(actor)
            switch result {
            case .enqueued(let remaining):
                log("receptionist", "yield \(actor.id) (remaining: \(remaining))")
            case .dropped(let value):
                log("receptionist", "dropped \(value)")
                return
            case .terminated:
                log("receptionist", "stream terminated")
                return
            @unknown default:
                fatalError("Unknown: \(result)")
            }
        }
    }

    // By casting known actors to the expected type, we filter
    // any potential actors of other type, which were stored under the same tag.
    //
    // We could implement this more efficiently, by storing multiple mappings collections,
    // and keying into them using (type, key), but this was a bit simpler for the sample.
    return newStream.compactMap { actor in
        actor as? Act
    }
}
    
}
