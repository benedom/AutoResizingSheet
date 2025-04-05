import SwiftUI

struct DynamicSheetContentView: View {
    @State private var text: String
    private let textToAppend = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam "
    private let defaultText = """
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam \
                nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, \
                sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. \
                Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. \
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam \
                nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
                """
    
    init() {
        _text = State(initialValue: defaultText)
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Lorem ipsum dolor sit amet")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(text)
                .font(.caption)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("⬆️ You can resize the sheet to full size using the grabber")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("📜 By default the sheets content is scrollable")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("↕️ Test the resizing by appending text or resetting it back to default")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                Button {
                    text = defaultText
                } label: {
                    Text("Reset text")
                }
                
                Spacer()
                
                Button {
                    text += textToAppend
                } label: {
                    Text("Append text")
                }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
    }
}
