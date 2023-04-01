//
//  APIRequest.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public protocol APIRequestable: AnyObject {
    
    var scheme: String? { get set }
    
    var host: String? { get set }
    
    var path: String? { get set }
    
    var port: Int? { get set }
    
    var queryItems: [URLQueryItem]? { get set }
    
    var method: APIMethod? { get set }
    
    var cachePolicy: URLRequest.CachePolicy? { get set }
    
    var timeoutInterval: TimeInterval? { get set }
    
    var headers: [String: String]? { get set }
    
    var body: Data? { get set }
    
    init()
    
    init(
        method: APIMethod?,
        scheme: String?,
        host: String?,
        port: Int?,
        path: String?,
        queryItems: [URLQueryItem]?,
        cachePolicy: URLRequest.CachePolicy?,
        timeoutInterval: TimeInterval?,
        headers: [String: String]?,
        body: Data?
    )
}

public extension APIRequestable {
   
    init(
        method: APIMethod?,
        scheme: String?,
        host: String?,
        port: Int?,
        path: String?,
        queryItems: [URLQueryItem]?,
        cachePolicy: URLRequest.CachePolicy?,
        timeoutInterval: TimeInterval?,
        headers: [String: String]?,
        body: Data?
    ) {
        self.init()
        self.method = method
        self.scheme = scheme
        self.host = host
        self.port = port
        self.path = path
        self.queryItems = queryItems
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
        self.headers = headers
        self.body = body
    }
    
    var url: URL {
        get throws {
            var components = URLComponents()
            if let path = path {
                components.path = path
            }
            components.scheme = scheme
            components.host = host
            components.port = port
            components.percentEncodedQueryItems = queryItems
            guard let url = components.url else { throw APIError.invalidUrl }
            return url
        }
    }
    
    @MainActor
    func response() async throws -> APIResponse {
        let url = try url
        var request = URLRequest(url: url,
                                 cachePolicy: cachePolicy ?? .useProtocolCachePolicy,
                                 timeoutInterval: timeoutInterval ?? 60)
        request.httpMethod = (method ?? .get).rawValue
        request.addHeaders(headers)
        request.httpBody = body
        print("NOAPI REQUEST URL: \(url)\nHEADS:\(String(describing: headers))\nBODY DAYA:\(body) BODY DICT: \((try? body?.dictionary) ?? [:])")
        let result = try await URLSession.shared.data(for: request)
        return APIResponse(data: result.0,
                           response: result.1,
                           request: request,
                           apiRequest: self)
    }
}
