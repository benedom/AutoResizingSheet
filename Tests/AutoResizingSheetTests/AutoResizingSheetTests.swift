import XCTest
@testable import AutoResizingSheet

final class AutoResizingSheetTests: XCTestCase {
    func testConfigurationInit() {
        let configuration = AutoResizingSheetConfiguration(
            scrollable: false,
            showGrabber: false,
            initialDetent: .large(),
            extendableToFullSize: false
        )
        XCTAssertEqual(configuration.scrollable, false)
        XCTAssertEqual(configuration.showGrabber, false)
        XCTAssertEqual(configuration.initialDetent, UISheetPresentationController.Detent.large())
        XCTAssertEqual(configuration.extendableToFullSize, false)
    }
}
