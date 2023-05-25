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
        

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            print("Error 1")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let data = data {
                let jsonDecoder = JSONDecoder()
                guard let json = try? jsonDecoder.decode(Array<BlogEntry>.self, from: data) else {
                    print("Error")
                    return
                }
                responseData.removeAll()
                for x in json {
                    responseData.append(x)
                }
            }
        }
        task.resume()
    }
    
    
}

struct WebApiClientDemo_Previews: PreviewProvider {
    static var previews: some View {
        WebApiClientDemo()
    }
}
