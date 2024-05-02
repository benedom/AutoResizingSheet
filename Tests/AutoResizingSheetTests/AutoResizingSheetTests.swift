import XCTest
@testable import AutoResizingSheet

final class AutoResizingSheetTests: XCTestCase {
    func testConfigurationInit() {
        let configuration = AutoResizingSheetConfiguration(
            scrollable: false,
            showGrabber: false,
            extendableToFullSize: false
        )
        XCTAssertEqual(configuration.scrollable, false)
        XCTAssertEqual(configuration.showGrabber, false)
        XCTAssertEqual(configuration.extendableToFullSize, false)
    }
}
