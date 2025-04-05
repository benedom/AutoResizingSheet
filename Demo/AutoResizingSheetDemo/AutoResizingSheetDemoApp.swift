import SwiftUI
import AutoResizingSheet

@main
struct AutoResizingSheetDemoApp: App {
    @State private var configuration = AutoResizingSheetConfiguration()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                SwiftUIExampleView(configuration: configuration)
                    .tabItem {
                        Label("SwiftUI", systemImage: "square.stack")
                    }
                
                UIKitExampleViewRepresentable(configuration: configuration)
                    .tabItem {
                        Label("UIKit", systemImage: "poweroutlet.type.a")
                    }
                
                ConfigurationSettingsView(configuration: $configuration)
                    .tabItem {
                        Label("Config", systemImage: "gear")
                    }
            }
        }
    }
}
