import Foundation

struct Event: Codable, Equatable {
    enum EventType: String, Codable {
        case server
        case episode
    }

    let type: EventType
    let timestamp: Date
    let title: String
    let description: String?

    init(type: EventType, title: String, description: String? = nil) {
        self.type = type
        self.timestamp = Date()
        self.title = title
        self.description = description
    }
}
