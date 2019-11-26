import Foundation

struct Event: Codable {
    enum EventType {
        case serverEvent
        case episode
    }

    let type: EventType
    let timestamp: Date
    let title: String
    let description: String?

    init(type: EventType, title: String, desc: String? = nil) {
        self.type = type
        self.timestamp = Date()
        self.title = title
        self.desc = desc
    }
}
