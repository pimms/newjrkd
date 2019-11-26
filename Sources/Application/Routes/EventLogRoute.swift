import Foundation
import Kitura
import KituraContracts

class EventLogRoute {
    func serverEventsHandler(completion: ([Event]?, RequestError?) -> Void) {
        let events = EventLog.default.events(withType: .server)
        completion(events, nil)
    }

    func episodeEventsHandler(completion: ([Event]?, RequestError?) -> Void) {
        let events = EventLog.default.events(withType: .episode)
        completion(events, nil)
    }
}

extension EventLogRoute: Routable {
    func register(in router: Router) {
        router.get("/logs/events", handler: serverEventsHandler)
        router.get("/logs/episodes", handler: episodeEventsHandler)
    }
}
