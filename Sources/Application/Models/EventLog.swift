import Foundation

class EventLog {
    private(set) events: [Event] = []

    func events(withType type: Event.EventType) -> [Event] {
        return events.filter { $0.type == type }
    }

    func add(event: Event) {
        events.append(event)
    }

    func trim(earlierThan time: Date) {
        events = events.filter { $0.timestamp < time }
    }
}
