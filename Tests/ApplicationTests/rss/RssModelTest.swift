import Foundation
import XCTest
@testable import Application

class RssModelTests: XCTestCase {
    func testDecode() {
        let xml =
        """
        <rss>
            <channel>
                <title>
                RSS Title
                </title>
                <description>
                RSS Description
                </description>
                <image>
                    <title>
                    Image Title
                    </title>
                    <url>
                    https://www.somesite.com/image.jpg
                    </url>
                    <link>
                    https://www.somesite.com/image
                    </link>
                    <width>
                    144
                    </width>
                    <height>
                    144
                    </height>
                </image>
                <link>
                    https://www.somesite.com/channel
                </link>
                <language>
                    no
                </language>
                <copyright>
                    Copyright Holder
                </copyright>
                <category>
                    Category
                </category>
                <item>
                    <title>
                        Item Title 1
                    </title>
                    <description>
                        Item Description 1
                    </description>
                    <guid isPermaLink="false">
                        Item GUID 1
                    </guid>
                    <enclosure url="https://www.somesite.com/item-1" length="150" type="audio/mpeg">
                    </enclosure>
                    <pubDate>
                        Thu, 19 Dec 2019 12:30:00 GMT
                    </pubDate>
                </item>
                <item>
                    <title>
                        Item Title 2
                    </title>
                    <description>
                        Item Description 2
                    </description>
                    <guid isPermaLink="false">
                        Item GUID 2
                    </guid>
                    <enclosure url="https://www.somesite.com/item-2" length="160" type="audio/mpeg">
                    </enclosure>
                    <pubDate>
                        Thu, 20 Dec 2019 12:30:00 GMT
                    </pubDate>
                </item>
            </channel>
        </rss>
        """

        let data = xml.data(using: .utf8)!
        switch RssFeed.decode(from: data) {
        case .success(let feed):
            verifyExpectations(feed)
        case .failure(let error):
            XCTFail("Failure! \(error)")
        }
    }

    private func verifyExpectations(_ feed: RssFeed) {
        XCTAssertEqual("RSS Title", feed.channel.title)
        XCTAssertEqual("RSS Description", feed.channel.description)
        XCTAssertEqual("https://www.somesite.com/channel", feed.channel.link.absoluteString)
        XCTAssertEqual("no", feed.channel.language)
        XCTAssertEqual("Copyright Holder", feed.channel.copyright)
        XCTAssertEqual("Category", feed.channel.category)

        let items = feed.channel.items
        XCTAssertEqual(2, items.count)

        XCTAssertEqual("Item Title 1", items[0].title)
        XCTAssertEqual("Item Description 1", items[0].description)
        XCTAssertEqual("Item GUID 1", items[0].guid)
        XCTAssertEqual("https://www.somesite.com/item-1", items[0].url.absoluteString)
        XCTAssertEqual(150, items[0].length!)
        XCTAssertEqual("audio/mpeg", items[0].type)
        XCTAssertEqual("Thu, 19 Dec 2019 12:30:00 GMT", items[0].pubDate)

        XCTAssertEqual("Item Title 2", items[1].title)
        XCTAssertEqual("Item Description 2", items[1].description)
        XCTAssertEqual("Item GUID 2", items[1].guid)
        XCTAssertEqual("https://www.somesite.com/item-2", items[1].url.absoluteString)
        XCTAssertEqual(160, items[1].length!)
        XCTAssertEqual("audio/mpeg", items[1].type)
        XCTAssertEqual("Thu, 20 Dec 2019 12:30:00 GMT", items[1].pubDate)
    }
}
