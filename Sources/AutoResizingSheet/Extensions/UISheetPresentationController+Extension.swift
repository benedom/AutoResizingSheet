import UIKit

extension UISheetPresentationController {
    /// Updates the height of the `UISheetPresentationController` with animation
    ///
    /// - Parameter height: New height for the `UISheetPresentationController`.
    func updateHeight(to height: CGFloat?) {
        guard let height else { return }
        
        let heightDetent: UISheetPresentationController.Detent = .custom { _ in
            height
        }
        var detents = [heightDetent]
        
        // Only add the large detent to resize if the grabber is shown and the heightDetent is not already large size
        if self.prefersGrabberVisible,
           !isHeightLargerThanLargeDetent(height: height) {
            detents.append(.large())
        }
        
        animateDetentChange(to: detents)
    }
    
    private func isHeightLargerThanLargeDetent(height: CGFloat) -> Bool {
        if let safeAreaInsetTop = containerView?.safeAreaInsets.top,
           let safeAreaInsetBottom = containerView?.safeAreaInsets.bottom {
            return (height + safeAreaInsetTop + safeAreaInsetBottom) > getViewHeight()
        } else {
            return (getViewHeight() * 0.9) < height
        }
    }
    
    private func getViewHeight() -> CGFloat {
        guard let viewHeight = self.presentedView?.window?.windowScene?.screen.bounds.size.height else {
            return UIScreen.main.bounds.height
        }
        
        return viewHeight
    }
    
    private func animateDetentChange(to detents: [UISheetPresentationController.Detent]) {
        self.animateChanges {
            self.detents = detents
        }
    }
}
