/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Wrapper around Network Framework Connection, simplifying sending and receiving messages.
*/

import Foundation
@preconcurrency import Network

struct Connection: Sendable {
  
  let connection: NWConnection
  let deliverMessage: @Sendable (Data?, NWProtocolFramer.Message) -> Void
  
  // outgoing connection
  init(endpoint: NWEndpoint, deliverMessage: @escaping @Sendable (Data?, NWProtocolFramer.Message) -> Void) {
    log("connection", "outgoing endpoint: \(endpoint)")
    let tcpOptions = NWProtocolTCP.Options()
    tcpOptions.enableKeepalive = true
    tcpOptions.keepaliveIdle = 2
    
    let parameters = NWParameters(tls: nil, tcp: tcpOptions)
    parameters.includePeerToPeer = true
    
    // add the protocol framing
    let framerOptions = NWProtocolFramer.Options(definition: WireProtocol.definition)
    parameters.defaultProtocolStack.applicationProtocols.insert(framerOptions, at: 0)
    
    connection = NWConnection(to: endpoint, using: parameters)
    self.deliverMessage = deliverMessage
    
    start()
  }
  
  // incoming connection
  init(connection: NWConnection, deliverMessage: @escaping @Sendable (Data?, NWProtocolFramer.Message) -> Void) {
    log("connection", "incoming connection: \(connection)")
    self.connection = connection
    self.deliverMessage = deliverMessage
    
    start()
  }
  
  func start() {
    connection.stateUpdateHandler = { newState in
      log("connection", "connection.stateUpdateHandler \(newState), connection: \(connection)")
      if case .ready = newState {
        self.receiveMessageLoop()
        return
      }
    }
    connection.start(queue: .main)
  }
  
  func receiveMessageLoop() {
    connection.receiveMessage { content, context, isComplete, error in
      if let decodedMessage = context?.protocolMetadata(definition: WireProtocol.definition) as? NWProtocolFramer.Message {
        self.deliverMessage(content, decodedMessage)
      }
      
      if let err = error {
        log("receive", "[error] Failed receiving: \(err)")
        return
      }
      
      self.receiveMessageLoop()
    }
  }
}

// - MARK: Sending messages

extension Connection {
  
  func sendRemoteCall(_ data: Data) {
    // create a message object to hold the command type
    let nwMessage = NWProtocolFramer.Message(wireMessageType: .remoteCall)
    let context = NWConnection.ContentContext(identifier: "RemoteCall", metadata: [nwMessage])
    
    connection.send(content: data, contentContext: context, isComplete: true, completion: .contentProcessed({ error in
      if let error = error {
        log("send-remoteCall", "[error] Connection send ERROR: \(error), connection:\(connection)")
      } else {
        log("send-remoteCall", "Connection send: OK, connection:\(connection)")
      }
    }))
  }
  
  func sendReply(_ data: Data) {
    // create a message object to hold the command type
    let nwMessage = NWProtocolFramer.Message(wireMessageType: .reply)
    let context = NWConnection.ContentContext(identifier: "Reply", metadata: [nwMessage])
    
    connection.send(content: data, contentContext: context, isComplete: true, completion: .contentProcessed({ error in
      if let error = error {
        log("send-reply", "[error] Connection send ERROR: \(error), connection:\(connection)")
      } else {
        log("send-reply", "Connection send: OK, connection:\(connection)")
      }
    }))
  }
  
}
