import Foundation

struct WebApiClient
{
    func requestAsync(request: URLRequest) async throws -> ApiResponse
    {
        do {
            let (_, response) = try await URLSession.shared.data(for: request)

            guard let response = response as? HTTPURLResponse else {
                return ApiResponse()
            }

            return ApiResponse(statusCode: response.statusCode)
            
        } catch {
            return ApiResponse(error: error)
        }
    }
    
    func requestWithResponseAsync<TResponseParser: ApiResponseParser>(request: URLRequest, parser: TResponseParser) async throws ->  ApiResponseWithBody<TResponseParser.TResponseBody>
    {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                return ApiResponseWithBody<TResponseParser.TResponseBody>()
            }
            
            return parser.parse(data: data, response: response)

        } catch {
            return ApiResponseWithBody<TResponseParser.TResponseBody>(error: error)
        }
    }
}
