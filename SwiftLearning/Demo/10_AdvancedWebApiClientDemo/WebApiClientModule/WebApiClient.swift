import Foundation

struct WebApiClient
{
    func requestAsync(request: URLRequest) async throws -> ApiResponse
    {
        do {
            let (_, response) = try await URLSession.shared.data(for: request)

            guard let response = response as? HTTPURLResponse else {
                return ApiResponse(statusCode: 0, error: nil)
            }

            return ApiResponse(statusCode: response.statusCode)
            
        } catch {
            return ApiResponse(statusCode: 0, error: error)
        }
    }
    
    func requestWithResponseAsync<TResponseParser: ApiResponseParser>(request: URLRequest, parser: TResponseParser) async throws ->  ApiResponseWithBody<TResponseParser.TResponseBody>
    {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                return ApiResponseWithBody<TResponseParser.TResponseBody>(statusCode: 0, responseBody: nil, error: nil)
            }
            
            return parser.parse(data: data, response: response)

        } catch {
            return ApiResponseWithBody<TResponseParser.TResponseBody>(statusCode: 0, responseBody: nil, error: error)
        }
    }

//    func requestWithResponseAsync<TResponseBody>(request: URLRequest, parser: ApiResponseParser<TResponseBody>) async throws ->  ApiResponseWithBody<TResponseBody>
//    {
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//
//            guard let response = response as? HTTPURLResponse else {
//                return ApiResponseWithBody<TResponseBody>(statusCode: 0, responseBody: nil, error: nil)
//            }
//
//            return parser.parse(data: data, response: response)
//
//        } catch {
//            return ApiResponseWithBody<TResponseBody>(statusCode: 0, responseBody: nil, error: error)
//        }
//    }

//    func requestWithResponseAsync<TResponse>(request: URLRequest, parser: ApiResponseParser<TResponse>) async throws -> TResponse
//        where TResponse: ApiResponseWithBody
//    {
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//
//            guard let response = response as? HTTPURLResponse else {
//                return TResponse(statusCode: 0, responseBody: nil, error: nil)
//            }
//
//            return parser.parse(data: data, response: response)
//
//        } catch {
//            return TResponse(statusCode: 0, responseBody: nil, error: error)
//        }
//    }
}
