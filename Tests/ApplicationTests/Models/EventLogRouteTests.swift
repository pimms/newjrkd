import XCTest
@testable import Application

final class EventLogRouteTests: XCTestCase {
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
        let expect = expectation(description: "callback called")
        let route = EventLogRoute(eventLog: eventLog)
        route.serverEventsHandler(completion: { events, error in
            XCTAssertNil(error)
            XCTAssertNotNil(events)
            XCTAssertEqual(serverEvents, events!)
            expect.fulfill()
        })
        waitForExpectations(timeout: 1.0)
    }

    func testEpisodeEventFiltering() {
        let expect = expectation(description: "callback called")
        let route = EventLogRoute(eventLog: eventLog)
        route.episodeEventsHandler(completion: { events, error in
            XCTAssertNil(error)
            XCTAssertNotNil(events)
            XCTAssertEqual(episodeEvents, events!)
            expect.fulfill()
        })
        waitForExpectations(timeout: 1.0)
    }
}
