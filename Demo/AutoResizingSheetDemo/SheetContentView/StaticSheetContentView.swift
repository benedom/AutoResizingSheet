import SwiftUI

struct StaticSheetContentView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Lorem ipsum dolor sit amet")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("""
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam \
                nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, \
                sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. \
                Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. \
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam \
                nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
                """)
                .font(.caption)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("⬆️ You can resize the sheet to full size using the grabber")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("📜 By default the sheets content is scrollable")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("❌ The sheet can be closed via the button or by swiping it down / touching the outside area")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                Text("Close sheet")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
    }
}
