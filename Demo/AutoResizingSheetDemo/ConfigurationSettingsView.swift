import AutoResizingSheet
import SwiftUI

struct ConfigurationSettingsView: View {
    @Binding var configuration: AutoResizingSheetConfiguration
    private let detents: [UISheetPresentationController.Detent] = [.medium(), .large()]
    
    var body: some View {
        VStack(spacing: 15) {
            Toggle("scrollable", isOn: $configuration.scrollable)
            
            Toggle("showGrabber", isOn: $configuration.showGrabber)
            
            DetentSelectionPicker(initialDetent: $configuration.initialDetent)
            
            Toggle("extendableToFullSize", isOn: $configuration.extendableToFullSize)
            
            Spacer()
        }
        .padding(20)
    }
    
    private struct DetentSelectionPicker: View {
        @Binding var initialDetent: UISheetPresentationController.Detent
        @State private var selectedDetent: DisplayableDetent
        private let displayableDetents: [DisplayableDetent]
        
        init(initialDetent: Binding<UISheetPresentationController.Detent>) {
            _initialDetent = initialDetent
            _selectedDetent = State(initialValue: DisplayableDetent(detent: initialDetent.wrappedValue))
            displayableDetents = [.init(detent: .medium()), .init(detent: .large())]
        }
        
        var body: some View {
            HStack {
                Text("initialDetent")
                
                Spacer()
                
                Menu {
                    ForEach(displayableDetents) { displayableDetent in
                        Button {
                            selectedDetent = displayableDetent
                        } label: {
                            Text(displayableDetent.name)
                        }
                    }
                } label: {
                    Text(selectedDetent.name)
                }
            }
            .onChange(of: selectedDetent) { selectedDetent in
                initialDetent = selectedDetent.detent
            }
        }
        
        private struct DisplayableDetent: Identifiable, Equatable {
            init(detent: UISheetPresentationController.Detent) {
                self.detent = detent
                if detent == .medium() {
                    name = "medium"
                } else {
                    name = "large"
                }
            }
            
            let id = UUID()
            let name: String
            let detent: UISheetPresentationController.Detent
        }
    }
}
