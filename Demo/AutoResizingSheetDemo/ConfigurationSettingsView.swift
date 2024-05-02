import AutoResizingSheet
import SwiftUI

struct ConfigurationSettingsView: View {
    @Binding var configuration: AutoResizingSheetConfiguration
    private let detents: [UISheetPresentationController.Detent] = [.medium(), .large()]
    
    var body: some View {
        VStack(spacing: 15) {
            Toggle("scrollable", isOn: $configuration.scrollable)
            
            Toggle("showGrabber", isOn: $configuration.showGrabber)
            
            Toggle("extendableToFullSize", isOn: $configuration.extendableToFullSize)
            
            Spacer()
        }
        .padding(20)
    }
}
