import SwiftUI

class AutoResizingSheetHostingController<Content: View>: UIHostingController<Content> {
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
