import SwiftUI

struct AdvancedWebApiClientDemo: View {
    
    @State private var responseData: Array<PostEntry> = []
    @State private var loading = false

    var body: some View {
        Group {
            
            if loading {
                ProgressView()
            } else {
                VStack(alignment: .leading) {
                    Text("\(responseData.count) entries")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.mint)
                    ScrollView {
                        ForEach(responseData){ x in
                            Text("- \(x.title)").lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            loading = true
            accessWebApi()
        }
    }
    
    
    func accessWebApi() {

        Task.detached {
            
            let clint = PostsApiClient()
            
            do {
                
                let response = try await clint.postsAsync()
                
                guard let posts = response.responseBody else {
                    return
                }
                
                try? await Task.sleep(nanoseconds: millisToNano(milliSecond: 2000))
                
                await MainActor.run {
                    responseData.removeAll()
                    for x in posts {
                        responseData.append(x)
                    }
                }
                
                loading = false
                
            } catch {
                print(error)
            }
        }
    }
}

struct AdvancedWebApiClientDemo_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedWebApiClientDemo()
    }
}
