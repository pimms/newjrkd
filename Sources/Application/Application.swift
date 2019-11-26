import Kitura
import Foundation

public class App {
    
    private let router = Router()

    private let routes: [Routable] = [
        EventLogRoute()
    ]

    public init() throws { }

    func postInit() throws {
        routes.forEach { route in
            route.register(in: router)
        }
    }

    public func run() throws {
        EventLog.default.add(event: Event(type: .server, title: "Started!"))

        try postInit()
        Kitura.addHTTPServer(onPort: 8080, with: router)
        Kitura.run()
    }
}
