import SwiftUI

struct CellView : View {

    @State private var info : Information
    
    init(info: Information)
    {
        self.info = info
    }
    
    var body : some View {
        HStack
        {
            SimpleThumnbnailView(info:info)
            VStack {
                Text(info.name).font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                Text(info.description).font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                Link("URL", destination: URL(string: info.userUrl)!)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.cyan)
        }
    }
    
    struct CellView_Preview : PreviewProvider {
        
        static var previews: some View {
            CellView(info: Information(
                name: "My Name",
                description: "description",
                thumbnailPath: "icon"
            ))
        }
    }

}
