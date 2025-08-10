import XCTest
@testable import PropertyExchange

final class CatalogTests: XCTestCase {
    func testResources() throws {
        XCTAssertFalse(PropertyExchangeCatalog.all.isEmpty)
        XCTAssertTrue(PropertyExchangeCatalog.all.contains("DeviceInfo"))
        XCTAssertTrue(PropertyExchangeCatalog.all.contains("ResourceList"))
        XCTAssertEqual(PropertyExchangeResource.DeviceInfo.rawValue, "DeviceInfo")
    }
}
