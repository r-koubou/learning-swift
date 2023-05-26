import SwiftUI

struct SimpleThumnbnailView : View {

    private let Width: CGFloat  = 90
    private let Height: CGFloat = 90

    private var info: Information

    init(info: Information) {
        self.info = info
    }
    
    var body : some View {
        ImageViewProxy.create(path: info.thumbnailPath, width: Width, height: Height) { image in
            image
                .resizable()
                .scaledToFit()
        } asyncImageHandle: { image in
            image
                .resizable()
                .scaledToFit()
        } placeholderHandle: {
            ProgressView()
        }
    }
    
    struct ThumnbnailView_Preview : PreviewProvider {
        
        static var previews: some View {
            ThumnbnailView(info: Information(
                name: "My Name",
                description: "description",
                thumbnailPath: "icon"
            ))
        }
    }
}
