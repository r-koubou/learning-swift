import UIKit.UIImage
import SwiftUI

struct ImageFromBinaryDemo: View {
    
    @State private var downloading = false
    @State private var downloadData : Data?

    var body: some View {
        VStack {
            if !downloading && downloadData != nil {
                Text("Tap image to download the next image")
                Button("or Unload") {
                    downloadData = nil
                }
                Image(uiImage: UIImage(data: downloadData!)!)
                    .onTapGesture {
                        downloadData = nil
                        downloadImage()
                    }
            }
            else if downloading {
                ProgressView{
                    Text("Downloading...")
                }
            } else {
                Button("Download") {
                    downloadImage()
                }
            }
        }
    }
    
    
    func downloadImage() {
        
        if(downloading) {
            return
        }
        
        downloading = true

        Task.detached {

            defer {
                downloading = false
            }
            
            let url = URL(string: "https://picsum.photos/400/400")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            await MainActor.run {
                downloadData = data
            }
        }
    }
}

struct ImageFromBinaryDemo_Previews: PreviewProvider {
    static var previews: some View {
        ImageFromBinaryDemo()
    }
}
