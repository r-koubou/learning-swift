import SwiftUI

protocol LazyLoadable {
    func load() async
}

struct ThumnbnailView : View, LazyLoadable {

    private var info: Information

    @State private var loaded = false
    @State private var image: Image?

    init(info: Information) {
        self.info = info
    }
    
    var body : some View {
        ZStack {
            Rectangle()
                .foregroundColor(.mint)
            if loaded {
                if image != nil {
                    image?.resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                }
            } else {
                ProgressView()
            }
        }
        .frame(width: 90, height: 90)
        .onAppear {
            load()
        }
    }
    
    func load() {
        let rand = TimeInterval.random(in: 0.5...2)
        DispatchQueue.main.asyncAfter(deadline: .now() + rand ) {
            image = Image(info.thumbnailPath)
            loaded = true
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
