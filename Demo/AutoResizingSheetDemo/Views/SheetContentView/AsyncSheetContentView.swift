import SwiftUI

struct AsyncSheetContentView: View {
    @State private var downloadedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Lorem ipsum dolor sit amet")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let downloadedImage {
                Image(uiImage: downloadedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Text("⬆️ You can resize the sheet to full size using the grabber")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("📜 By default the sheets content is scrollable")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("🛜 The sheet simulates a async sheet where the content changes it's size after data is loaded")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Button {
                Task {
                    downloadedImage = nil
                    downloadedImage = await downloadExampleImage()
                }
            } label: {
                Text("Reload image")
            }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
        .onAppear {
            Task {
                downloadedImage = await downloadExampleImage()
            }
        }
    }
    
    // Example function for downloading an image
    private func downloadExampleImage() async -> UIImage? {
        let urlString = "https://picsum.photos/1000/1200"
        guard let url = URL(string: urlString),
              let (data, _) = try? await URLSession.shared.data(from: url),
              let image = UIImage(data: data)
        else { return nil }
        
        return image
    }
}
