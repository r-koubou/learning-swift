import SwiftUI

struct TabViewDemo: View {
    var body: some View {
        TabView {
            AsyncScrollViewDemo().tabItem {
                Image(systemName: "message.fill")
                Text("Message")
            }
            AsyncScrollViewDemo().tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            AsyncScrollViewDemo().tabItem {
                Image(systemName: "camera.fill")
                Text("Camera")
            }
        }
        .accentColor(.cyan)
    }
}


struct TabViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        TabViewDemo()
    }
}
