@testable import Common
import XCTest

final class CommonTests: XCTestCase {
    // This is just a small sample text case, a full productin app should
    // include multiple test cased covering both happy & unhappy code paths

    func testBrandred() throws {
        XCTAssertEqual(UIColor.VirginMoney.red, UIColor(red: 196 / 255, green: 2 / 255, blue: 2 / 255, alpha: 1))
    }

    func testBrandPrimaryColor() throws {
        XCTAssertEqual(UIColor.VirginMoney.red, UIColor.VirginMoney.primary)
    }
    
    func testCapitalisePropertyWrapper() throws {
        @Capitalized var test = "hello"
        XCTAssertEqual(test, "Hello")
    }
}
