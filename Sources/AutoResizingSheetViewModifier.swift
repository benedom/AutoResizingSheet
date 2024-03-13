import SwiftUI
import UIKit

/// Used to present an auto resizing sheet in a SwiftUI `View`
struct AutoResizingSheetViewModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let configuration: AutoResizingSheetConfiguration
    let presentingViewController: UIViewController?
    let sheetContent: () -> SheetContent
    @State private var hostingController: SheetHostingController<AutoResizingSheetView<SheetContent>>?
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { newValue in
                if newValue {
                    presentSheet(sheetContent: sheetContent)
                } else {
                    hostingController?.dismiss(animated: true)
                }
            }
    }
    
    private func presentSheet(sheetContent: @escaping () -> SheetContent) {
        let view = AutoResizingSheetView(
            sheetPresentationController: nil,
            scrollable: configuration.scrollable,
            content: sheetContent
        )
        let hostingController = SheetHostingController(
            isPresented: $isPresented,
            onDismiss: onDismiss,
            rootView: view
        )
        hostingController.setSheetPresentationStyle(with: configuration)
        hostingController.rootView.sheetPresentationController = hostingController.sheetPresentationController
        
        self.hostingController = hostingController
        
        if let presentingViewController {
            presentingViewController.present(hostingController, animated: true)
        } else {
            guard let topViewController = UIApplication.shared.firstKeyWindow?.rootViewController else {
                return
            }
            topViewController.present(hostingController, animated: true)
        }
    }
}

class SheetHostingController<Content: View>: UIHostingController<Content> {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    
    init(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)?,
        rootView: Content
    ) {
        _isPresented = isPresented
        self.onDismiss = onDismiss
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isPresented = false
        onDismiss?() // TODO: Test if it works
    }
}

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
