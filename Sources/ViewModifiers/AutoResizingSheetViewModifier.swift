import SwiftUI

struct AutoResizingSheetViewModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let configuration: AutoResizingSheetConfiguration
    let presentingViewController: UIViewController?
    let sheetContent: () -> SheetContent
    @State private var hostingController: AutoResizingSheetHostingController<AutoResizingSheetView<SheetContent>>?
    
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
        let hostingController = AutoResizingSheetHostingController(
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
