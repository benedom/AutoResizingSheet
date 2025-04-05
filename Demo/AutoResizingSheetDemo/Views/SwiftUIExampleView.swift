import SwiftUI
import AutoResizingSheet

struct SwiftUIExampleView: View {
    let configuration: AutoResizingSheetConfiguration
    @State private var showStaticSheet = false
    @State private var showDynamicSheet = false
    @State private var showAsyncSheet = false
    
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
    }
}

#Preview {
    SwiftUIExampleView(configuration: AutoResizingSheetConfiguration())
}
