import UIKit

/// `AutoResizingSheetConfiguration` is a struct that defines the configuration for the auto resizing sheet.
public struct AutoResizingSheetConfiguration {
    public var scrollable: Bool
    public var showGrabber: Bool
    public var extendableToFullSize: Bool
    
    /// Creates a new instance of `AutoResizingSheetConfiguration`.
    /// 
    /// - Note: The resizing will not work properly if your view is wrapped inside a `ScrollView`. Use `scrollable` of `AutoResizingSheetConfiguration` instead, to make the content scrollable.
    ///
    /// - Parameters:
    ///   - scrollable: Should the content be wrapped inside a scroll view.
    ///                            Defaults to `true`.
    ///   - showGrabber: If the grabber should be shown.
    ///                            Defaults to `true`.
    ///   - extendableToFullSize: If the sheet is extendable  to full size using the grabber.
    ///                            Defaults to `true`, will be `false` if `showGrabber` is `false`.
    ///
    public init(
        scrollable: Bool = true,
        showGrabber: Bool = true,
        extendableToFullSize: Bool = true
    ) {
        self.scrollable = scrollable
        self.showGrabber = showGrabber
        if !showGrabber {
            self.extendableToFullSize = false
        } else {
            self.extendableToFullSize = extendableToFullSize
        }
    }
}
