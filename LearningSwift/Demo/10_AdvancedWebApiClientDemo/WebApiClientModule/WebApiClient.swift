import Foundation

struct WebApiClient
{
    func appendHttpRequestHeader(request: inout URLRequest, key: String, value: String)
    {
        guard !key.isEmpty && !value.isEmpty else {
            return
        }

        request.addValue(value, forHTTPHeaderField: key)
    }

    func setRequestBodyForUploadBytes(request: inout URLRequest, bytes: inout [UInt8], mime: String = "application/octet-stream") throws
    {
        guard bytes.count > 0 else {
            throw NSError(domain: "WebApiClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "bytes is empty."])
        }
        
        request.httpBody = Data(bytes)
        request.setValue(mime, forHTTPHeaderField: "Content-Type")
    }
    
    typealias BoundaryString = String
    
    func setRequestBodyForMultiPartData(request: inout URLRequest, _ appendingData: (inout Data, BoundaryString)->Void) throws
    {
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        appendingData(&data, boundary)
        request.httpBody = data
    }

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
