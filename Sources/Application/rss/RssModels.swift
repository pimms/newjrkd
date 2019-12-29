import Foundation
import XMLParsing

struct RssFeed: Codable {
    let channel: RssChannel
}

struct RssChannel: Codable {
    let title: String
    let description: String
    let image: RssImage
    let link: URL
    let language: String
    let copyright: String
    let category: String
    let items: [RssItem]

    enum CodingKeys: String, CodingKey {
        case title, description, image, link, language, copyright, category

        case items = "item"
    }
}

struct RssImage: Codable {
    let title: String
    let url: URL
    let link: URL?
    let width: Int
    let height: Int
}

struct RssItem: Codable {
    private struct RssItemEnclosure: Codable {
        let url: URL
        let length: Int?
        let type: String?
    }

    let title: String
    let description: String
    let guid: String
    private let enclosure: RssItemEnclosure
    let pubDate: String

    var url: URL { enclosure.url }
    var length: Int? { enclosure.length }
    var type: String? { enclosure.type }
}

// MARK: - Decoding

extension RssFeed {
    static func decode(from data: Data) -> Result<RssFeed, Error> {
        do {
            let feed = try XMLDecoder().decode(RssFeed.self, from: data)
            return .success(feed)
        } catch (let err) {
            return .failure(err)
        }
    }
}
