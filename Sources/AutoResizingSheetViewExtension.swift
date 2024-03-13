import UIKit
import SwiftUI

/// Used to present an auto resizing sheet as a `UIHostingController`
public extension UIViewController {
    /// Presents a SwiftUI view as sheet that will update its height automatically.
    /// If the height of the content changes (e.g. after fetching data), the height is updated with an animation
    ///
    /// - Note: The resizing will not work properly if your view is wrapped inside a `ScrollView`. Use `scrollable` of `AutoResizingSheetConfiguration` instead, to make the content scrollable.
    ///
    /// - Parameters:
    ///    - content: The content of the sheet view (e.g. a `VStack`).
    ///    - configuration: The configuration to use for the sheet.
    ///    - onDismiss: The closure to execute when dismissing the sheet.
    func presentViewAsAutoResizingSheet<Content: View>(
        content: @escaping () -> Content,
        configuration: AutoResizingSheetConfiguration = AutoResizingSheetConfiguration(),
        onDismiss: (() -> Void)?
    ) {
        let autoResizingSheetView = AutoResizingSheetView(
            sheetPresentationController: nil,
            scrollable: configuration.scrollable,
            content: content
        )
        let hostingController = UIHostingController(rootView: autoResizingSheetView)
        hostingController.setSheetPresentationStyle(with: configuration)
        hostingController.rootView.sheetPresentationController = hostingController.sheetPresentationController
        
        self.present(hostingController, animated: true)
    }
}
