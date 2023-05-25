import Foundation

protocol ApiResponseBase
{
    var statusCode: Int { get }
    var error: Error? {get}
}

struct ApiResponse : ApiResponseBase
{
    let statusCode: Int
    let error: Error?

    init(statusCode: Int, error: Error? = nil) {
        self.statusCode = statusCode
        self.error = error
    }
}

struct ApiResponseWithBody<TResponseBody> : ApiResponseBase
{
    let statusCode: Int
    let responseBody: TResponseBody?
    let error: Error?

    init(statusCode: Int, responseBody: TResponseBody?, error: Error?)
    {
        self.statusCode = statusCode
        self.responseBody = responseBody
        self.error = error
    }
}


//struct ApiResponseWithBody<TResponseBody> : ApiResponseBase
//{
//    let statusCode: Int
//    let responseBody: TResponseBody?
//    let error: Error?
//
//    init(statusCode: Int, responseBody: TResponseBody?, error: Error?)
//    {
//        self.statusCode = statusCode
//        self.responseBody = responseBody
//        self.error = error
//    }
//}

