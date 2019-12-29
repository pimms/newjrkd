import XCTest
@testable import Application

final class EventLogRouteTests: JRKTestCase {
    private let eventLog = EventLog()
    private let serverEvents = [
        Event(type: .server, title: "se 1", description: nil),
        Event(type: .server, title: "se 2", description: "nice desc"),
    ]
    private let episodeEvents = [
        Event(type: .episode, title: "ee 1", description: nil),
        Event(type: .episode, title: "ee 2", description: "also nice desc"),
    ]

    override func setUp() {
        super.setUp()
        serverEvents.forEach { eventLog.add(event: $0) }
        episodeEvents.forEach { eventLog.add(event: $0) }
    }

    func testServerEventFiltering() {
        let route = EventLogRoute(eventLog: eventLog)
        assertRouteResponse(route.serverEventsHandler(completion:), toBe: serverEvents)
    }

    func testEpisodeEventFiltering() {
        let route = EventLogRoute(eventLog: eventLog)
        assertRouteResponse(route.episodeEventsHandler(completion:), toBe: episodeEvents)
    }
}
