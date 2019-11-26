import Foundation
import Kitura
import XCTest
@testable import Application

class JRKTestCase: XCTestCase {
    func assertRouteResponse<T>(_ handler: @escaping ((T?, RequestError?) -> Void) -> Void, toBe expectedValue: T) where T: Codable & Equatable {
        let expect = expectation(description: "handler must be called")

        handler { actualValue, error in
            XCTAssertNotNil(actualValue)
            XCTAssertEqual(expectedValue, actualValue!)
            expect.fulfill()
        }

        waitForExpectations(timeout: 5.0)
    }

    func assertRouteResponse<T>(_ handler: @escaping ((T?, RequestError?) -> Void) -> Void, toFailWith expectedError: RequestError) {
        let expect = expectation(description: "handler must be called")

        handler { value, actualError in
            XCTAssertNil(value)
            XCTAssertNotNil(actualError)
            XCTAssertEqual(expectedError, actualError)
            expect.fulfill()
        }

        waitForExpectations(timeout: 5.0)
    }
}
