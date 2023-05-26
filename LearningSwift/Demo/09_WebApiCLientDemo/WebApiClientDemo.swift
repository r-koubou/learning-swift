import SwiftUI

struct BlogEntry: Codable, Identifiable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

struct WebApiClientDemo: View {
    
    @State private var responseData: Array<BlogEntry> = []
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
            do {
                guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
                    return
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let jsonDecoder = JSONDecoder()
                guard let json = try? jsonDecoder.decode(Array<BlogEntry>.self, from: data) else {
                    return
                }
                
                try? await Task.sleep(nanoseconds: millisToNano(milliSecond: 2000))

                await MainActor.run {
                    responseData.removeAll()
                    for x in json {
                        responseData.append(x)
                    }
                }
                
                loading = false
               

            } catch {
                print("Error")
                print(error)
            }
        }
    }
    
    
}

struct WebApiClientDemo_Previews: PreviewProvider {
    static var previews: some View {
        WebApiClientDemo()
    }
}
