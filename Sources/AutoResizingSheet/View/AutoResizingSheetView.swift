import SwiftUI

/// Creates a sheet view with content that will update its height automatically.
/// If the height of the content changes (e.g. after fetching data), the height is updated with an animation
///
/// - Parameters:
///     - sheetPresentationController: The `UISheetPresentationController` where the new detent height is set.
///     - scrollable: Should the content be wrapped inside a scroll view.
///     - content: The content of the sheet view (e.g. a `VStack` with elements)
struct AutoResizingSheetView<Content: View>: View {
    var sheetPresentationController: UISheetPresentationController?
    private let scrollable: Bool
    private var content: Content
    @State private var viewHeight: CGFloat?
    
    init(
        sheetPresentationController: UISheetPresentationController?,
        scrollable: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.sheetPresentationController = sheetPresentationController
        self.scrollable = scrollable
        self.content = content()
    }
    
    var body: some View {
        Group {
            if scrollable {
                ScrollView(.vertical) {
                    content
                        .readSize { size in
                            updateViewHeight(newHeight: size.height)
                        }
                }
            } else {
                VStack {
                    content
                        .readSize { size in
                            updateViewHeight(newHeight: size.height)
                        }
                    
                    Spacer()
                }
            }
        }
    }
    
    private func updateViewHeight(newHeight: CGFloat) {
        if newHeight != viewHeight {
            viewHeight = newHeight
            sheetPresentationController?.updateHeight(to: viewHeight)
        }
    }
}
