import SwiftUI

struct AdvancedWebApiClientDemo: View {
    
    @State private var responseData: Array<PostEntry> = []
    
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                Text("\(responseData.count) entries")
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(responseData){ x in
                            Text("- \(x.title)").lineLimit(1)
                                .padding(.bottom)
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
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
                
                responseData.removeAll()
                for x in posts {
                    responseData.append(x)
                }
                
            } catch {
                print(error)
            }
        }
        
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
//            print("Error 1")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if let data = data {
//                let jsonDecoder = JSONDecoder()
//                guard let json = try? jsonDecoder.decode(Array<BlogEntry>.self, from: data) else {
//                    print("Error")
//                    return
//                }
//                responseData.removeAll()
//                for x in json {
//                    responseData.append(x)
//                }
//            }
//        }
//        task.resume()
    }
    
    
}

struct AdvancedWebApiClientDemo_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedWebApiClientDemo()
    }
}
