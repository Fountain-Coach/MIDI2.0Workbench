import XCTest
@testable import PropertyExchange

final class MessageTests: XCTestCase {
    func testMessageCases() throws {
        XCTAssertTrue(PropertyExchangeMessage.allCases.contains(.inquiryGetPropertyData))
        XCTAssertTrue(PropertyExchangeMessage.allCases.contains(.replyToGetPropertyData))
    }
}
