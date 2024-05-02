import SwiftUI
import AutoResizingSheet

struct ContentView: View {
    @State private var showStaticSheet = false
    @State private var showDynamicSheet = false
    @State private var showAsyncSheet = false
    @State private var showConfigurationSettings = false
    @State private var configuration = AutoResizingSheetConfiguration()
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Button {
                showStaticSheet.toggle()
            } label: {
                Text("Show static sheet")
            }
            
            Button {
                showDynamicSheet.toggle()
            } label: {
                Text("Show dynamic sheet")
            }
            
            Button {
                showAsyncSheet.toggle()
            } label: {
                Text("Show async sheet")
            }
            
            Spacer()
            
            Button {
                showConfigurationSettings.toggle()
            } label: {
                Image(systemName: "gearshape")
                
                Text("Configuration Settings")
            }
        }
        .padding()
        .autoResizingSheet(
            isPresented: $showStaticSheet,
            configuration: configuration
        ) {
            StaticSheetContentView()
            
        }
        .autoResizingSheet(
            isPresented: $showDynamicSheet,
            configuration: configuration
        ) {
            DynamicSheetContentView()
        }
        .autoResizingSheet(
            isPresented: $showAsyncSheet,
            configuration: configuration
        ) {
            AsyncSheetContentView()
        }
        .sheet(isPresented: $showConfigurationSettings) {
            ConfigurationSettingsView(configuration: $configuration)
        }
    }
}

#Preview {
    ContentView()
}
