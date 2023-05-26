import Foundation


protocol ApiResponseParser
{
    associatedtype TResponseBody
    func parse(data: Data, response: HTTPURLResponse) -> ApiResponseWithBody<TResponseBody>
}


struct JsonResponseParser<TResponse: Decodable> : ApiResponseParser
{
    func parse(data: Data, response: HTTPURLResponse) -> ApiResponseWithBody<TResponse>
    {
        guard response.statusCode >= 200 || response.statusCode < 400 else {
            return ApiResponseWithBody(statusCode: response.statusCode)
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let responseBody = try jsonDecoder.decode(TResponse.self, from: data)
            return ApiResponseWithBody(statusCode: response.statusCode, responseBody: responseBody)
            
        } catch {
            return ApiResponseWithBody(statusCode: response.statusCode, error: error)
        }
    }
}
