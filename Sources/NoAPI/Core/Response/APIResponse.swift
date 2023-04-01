//
//  APIResponse.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public final class APIResponse {
    
    public var statusCode: Int?
    
    public var data: Data?
    
    public var response: URLResponse?
    
    public var request: URLRequest?
    
    public var apiRequest: APIRequestable?
    
    public var httpResponse: HTTPURLResponse? {
        return response as? HTTPURLResponse
    }
    
    public init(
        data: Data? = nil,
        response: URLResponse? = nil,
        request: URLRequest? = nil,
        apiRequest: APIRequestable? = nil
    ) {
        self.data = data
        self.response = response
        self.request = request
        self.apiRequest = apiRequest
        statusCode = httpResponse?.statusCode
        print("NOAPI Response code: \(statusCode ?? 0)\nBody: \(String(describing: try? data?.jsonObject))")
    }
}

public extension APIResponse {
    
    func hasHeader(key: String) -> Bool {
        httpResponse?.allHeaderFields.keys.contains(key) ?? false
    }
    
    func headerValue(key: String) -> Any? {
        guard hasHeader(key: key),
              let headers = httpResponse?.allHeaderFields
        else { return nil }
        return headers[key]
    }
}
