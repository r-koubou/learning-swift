import SwiftUI

struct AsyncScrollViewDemo : View
{
    @State private var informations : [Information] = []
    @State private var count = 1

    var body : some View {
        VStack {
            Button("Add") {
                informations.append(Information(
                    name: "Name \(count)",
                    description: "desscription of \(count)",
                    thumbnailPath: "https://picsum.photos/320/320"
                ))
                count += 1
            }

            Button("Clear") {
                informations.removeAll()
                count = 1
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(self.informations, id: \.self) { x in
                        CellView(info: x)
                    }
                }
            }
            .padding()
        }
    }
    
    struct AsyncScrollViewDemo_Preview : PreviewProvider {
        
        static var previews: some View {
            AsyncScrollViewDemo()
        }
    }
}
