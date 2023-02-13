/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Decoder type that is used to decode remote calls.
*/

import Foundation
import Distributed
import os
import Network

@available(iOS 16.0, *)
public class SampleLocalNetworkCallEncoder: DistributedTargetInvocationEncoder,
    @unchecked Sendable {
    public typealias SerializationRequirement = Codable

    var genericSubs: [String] = []
    var argumentData: [Data] = []

    public func recordGenericSubstitution<T>(_ type: T.Type) throws {
        if let name = _mangledTypeName(T.self) {
            genericSubs.append(name)
        }
    }

    public func recordArgument<Value: SerializationRequirement>(_ argument: RemoteCallArgument<Value>) throws {
        let data = try JSONEncoder().encode(argument.value)
        self.argumentData.append(data)
    }

    public func recordReturnType<R: SerializationRequirement>(_ type: R.Type) throws {
        // noop, no need to record it in this system
    }

    public func recordErrorType<E: Error>(_ type: E.Type) throws {
        // noop, no need to record it in this system
    }

    public func doneRecording() throws {
        // noop, nothing to do in this system
    }

}
