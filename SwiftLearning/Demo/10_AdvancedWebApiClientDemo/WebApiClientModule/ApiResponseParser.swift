import Foundation


protocol ApiResponseParser
{
    associatedtype TResponseBody
    func parse(data: Data, response: HTTPURLResponse) -> ApiResponseWithBody<TResponseBody>
}


struct JsonResponseParser<TResponseBody: Decodable> : ApiResponseParser
{
    func parse(data: Data, response: HTTPURLResponse) -> ApiResponseWithBody<TResponseBody>
    {
        print("**** Response: \(response.statusCode)")
        guard response.statusCode >= 200 || response.statusCode < 400 else {
            return ApiResponseWithBody(statusCode: response.statusCode, responseBody: nil, error: nil)
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let responseBody = try jsonDecoder.decode(TResponseBody.self, from: data)
            return ApiResponseWithBody(statusCode: response.statusCode, responseBody: responseBody, error: nil)
            
        } catch {
            return ApiResponseWithBody(statusCode: response.statusCode, responseBody: nil, error: error)
        }
    }
}


//struct ApiResponseParser<TResponseBody>
//{
//    typealias ParserBody = (Data, HTTPURLResponse)-> TResponseBody?
//
//    private let parseCode: ParserBody
//
//    init(parseImpl: @escaping ParserBody) {
//        self.parseCode = parseImpl
//    }
//
//    func parse(data: Data, response: HTTPURLResponse) -> TResponseBody?
//    {
//        return self.parseCode(data, response)
//    }
//}

//struct JsonResponseParser<TResponseBody> where TResponseBody: Decodable
//{
//    func parse(data: Data, response: HTTPURLResponse) -> TResponseBody?
//    {
//        let jsonDecoder = JSONDecoder()
//
//        guard let json = try? jsonDecoder.decode(TResponseBody.self, from: data) else {
//            return nil
//        }
//
//        return json
//    }
//}

//protocol ApiResponseParser
//{
//    associatedtype TApiResponse
//    func parse(data: Data, response: HTTPURLResponse) -> TApiResponse?
//}
//
//struct JsonParser<TResponseBody>: ApiResponseParser where TResponseBody : Decodable
//{
//    func parse(data: Data, response: HTTPURLResponse) -> TResponseBody?
//    {
//        let jsonDecoder = JSONDecoder()
//
//        guard let json = try? jsonDecoder.decode(TResponseBody.self, from: data) else {
//            return nil
//        }
//
//        return json
//    }
//}
