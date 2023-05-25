import Foundation

struct PostsApiClient
{
    func postsAsync() async throws -> ApiResponseWithBody<[PostEntry]>
    {
        var request = URLRequest(url: URL(string: "\(BaseUrl.Production.rawValue)/posts")!)
        request.httpMethod = "GET"
                
        return try await WebApiClient()
            .requestWithResponseAsync(request: request, parser: JsonResponseParser<[PostEntry]>())
    }
}
