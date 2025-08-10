import XCTest
@testable import Profiles

final class CatalogTests: XCTestCase {
    func testLookupAndResources() throws {
        // Expect at least one known profile (from libs/profiles.js)
        XCTAssertFalse(ProfilesCatalog.all.isEmpty)
        if let p = ProfilesCatalog.lookup(bank: 0x21, index: 0x00) {
            XCTAssertEqual(p.name, "Default Control Change Mapping")
        }
    }
}

