import Foundation

struct ApiResponse
{
    let statusCode: Int
    let error: Error?

    init(statusCode: Int = 0, error: Error? = nil) {
        self.statusCode = statusCode
        self.error = error
    }
}

struct ApiResponseWithBody<TResponseBody>
{
    let statusCode: Int
    let responseBody: TResponseBody?
    let error: Error?

    init(statusCode: Int = 0, responseBody: TResponseBody? = nil, error: Error? = nil)
    {
        self.statusCode = statusCode
        self.responseBody = responseBody
        self.error = error
    }
}
