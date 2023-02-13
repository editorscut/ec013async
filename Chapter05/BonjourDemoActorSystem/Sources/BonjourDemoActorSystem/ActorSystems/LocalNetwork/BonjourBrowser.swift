/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A wrapper around Network Framework browser, simplifying discovering new services.
*/

import Foundation
import Network

final class Browser {
    let browser: NWBrowser
    let nodeName: String

    init(nodeName: String, serviceName: String) {
        self.nodeName = nodeName

        let parameters = NWParameters()
        parameters.includePeerToPeer = true

        browser = NWBrowser(for: .bonjour(type: serviceName, domain: nil), using: parameters)
    }

    func start(handler: @escaping (NWBrowser.Result) -> Void) {
        browser.browseResultsChangedHandler = { results, changes in
            for result in results {
                if case NWEndpoint.service(let nodeName, type: _, domain: _, interface: _) = result.endpoint {
                    log("browser", "incoming endpoint, nodeName: \(nodeName) (self.nodeName: \(self.nodeName))")
                    guard nodeName != self.nodeName else {
                        log("browser", "Ignore, result about nodeName: \(self.nodeName) \(result)")
                        return
                    }

                    log("browser", "Accept, offer to handler incoming endpoint. NodeName: \(nodeName)]")
                    handler(result)
                }
            }
        }
        browser.start(queue: .main)
    }
}
