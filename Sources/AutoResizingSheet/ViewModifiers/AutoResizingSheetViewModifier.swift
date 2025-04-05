import SwiftUI

struct AutoResizingSheetViewModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let configuration: AutoResizingSheetConfiguration
    let sheetContent: () -> SheetContent
    @State private var detents: Set<PresentationDetent>
    @State private var selectedDetent: PresentationDetent
    
    init(
        isPresented: Binding<Bool>,
        configuration: AutoResizingSheetConfiguration,
        sheetContent: @escaping () -> SheetContent
    ) {
        _isPresented = isPresented
        self.configuration = configuration
        self.sheetContent = sheetContent as () -> SheetContent
        
        let initialDetent: PresentationDetent = .medium
        _selectedDetent = State(initialValue: initialDetent)
        _detents = State(initialValue: [initialDetent])
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                if configuration.scrollable {
                    ScrollView {
                        sheetContent()
                            .presentationDetents(detents, selection: $selectedDetent)
                            .presentationDragIndicator(configuration.showGrabber ? .visible : .hidden)
                            .readSize { newSize in
                                updateDetents(newHeigh: newSize.height)
                            }
                    }
                    .background(Color(configuration.scrollBackground))
                } else {
                    sheetContent()
                        .presentationDetents(detents, selection: $selectedDetent)
                        .presentationDragIndicator(configuration.showGrabber ? .visible : .hidden)
                        .readSize { newSize in
                            updateDetents(newHeigh: newSize.height)
                        }
                }
            }
    }
    
    private func updateDetents(newHeigh: CGFloat) {
        let newDetent = getNewDetent(height: newHeigh)
        
        if !detents.contains(newDetent) {
            detents.insert(newDetent)
        }
        
        // Remove the initial medium detent
        if detents.contains(.medium) {
            detents.remove(.medium)
        }
        
        // Adjust full size detent
        let shouldShowFullSize = configuration.extendableToFullSize && configuration.showGrabber
        if shouldShowFullSize,
           !detents.contains(.large) {
            detents.insert(.large)
        } else {
            detents.remove(.large)
        }
        
        selectedDetent = newDetent
    }
    
    private func getNewDetent(height: CGFloat) -> PresentationDetent {
        if isHeightFullScreenHeight(height: height) {
            return .large
        } else {
            return .height(height)
        }
    }
    
    private func isHeightFullScreenHeight(height: CGFloat) -> Bool {
        height >= UIScreen.main.bounds.height
    }
}
