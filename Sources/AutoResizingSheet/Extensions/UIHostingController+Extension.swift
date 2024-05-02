import SwiftUI

extension UIHostingController {
    /// Sets the correct sheet presentation style for sheets.
    ///
    /// - Parameter configuration: The `AutoResizingSheetConfiguration` to use.
    func setSheetPresentationStyle(with configuration: AutoResizingSheetConfiguration) {
        self.modalPresentationStyle = .pageSheet
        self.sheetPresentationController?.prefersGrabberVisible = configuration.showGrabber
        var detents: [UISheetPresentationController.Detent] = [.medium()]
        if !detents.contains(.large()),
           configuration.showGrabber,
           configuration.extendableToFullSize {
            detents.append(.large())
        }
        self.sheetPresentationController?.detents = detents
    }
}
