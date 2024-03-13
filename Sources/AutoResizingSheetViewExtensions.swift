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

/// Used to present an auto resizing sheet in a SwiftUI `View
public extension View {
    /// Creates a sheet view with content that will update its height automatically.
    /// If the height of the content changes (e.g. after fetching data), the height is updated with an animation
    ///
    /// - Note: The resizing will not work properly if your view is wrapped inside a `ScrollView`. Use `scrollable` of `AutoResizingSheetConfiguration` instead, to make the content scrollable.
    ///
    /// - Parameters:
    ///    - isPresented: Binding to control the presentation of the sheet.
    ///    - onDismiss: The closure to execute when dismissing the sheet.
    ///    - configuration: The configuration to use for the sheet.
    ///    - presentingViewController: The sheet is presented as a `UIHostingController` so it needs a `UIViewController` that presents it. If you do not supply one, the rootViewController is searched, which may fail.
    ///    - content: The content of the sheet view (e.g. a `VStack`).
    func selfResizingSheet<Content: View>(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        configuration: AutoResizingSheetConfiguration = AutoResizingSheetConfiguration(),
        presentingViewController: UIViewController?,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(AutoResizingSheetViewModifier(
            isPresented: isPresented,
            onDismiss: onDismiss,
            configuration: configuration,
            presentingViewController: presentingViewController,
            sheetContent: content
        ))
    }
}
