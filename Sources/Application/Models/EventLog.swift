import Foundation

class EventLog {
    static let `default` = EventLog()

    private var events: [Event] = []

    func events(withType type: Event.EventType) -> [Event] {
        return events.filter { $0.type == type }
    }

    func add(event: Event) {
        let oneDayAgo = Date(timeIntervalSinceNow: -86400)
        trim(earlierThan: oneDayAgo)
        events.append(event)
    }

    private func trim(earlierThan time: Date) {
        events = events.filter { $0.timestamp >= time }
    }
}
