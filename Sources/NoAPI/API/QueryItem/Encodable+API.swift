//
//  Encodable+API.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public extension Encodable {
    
//    func request<Request: APIRequestable>(
//        method: APIMethod? = nil,
//        scheme: String? = nil,
//        host: String? = nil,
//        path: String? = nil,
//        cachePolicy: URLRequest.CachePolicy? = nil,
//        timeoutInterval: TimeInterval? = nil,
//        headers: [String: String]? = nil,
//        encoder: JSONEncoder? = nil
//    ) throws -> Request {
//        var req = Request()
//        req.method = method
//        if method == .get {
//            req = try req.setQuery(object: self, using: encoder)
//        } else {
//            req = try req.setBody(self, using: encoder)
//        }
//        return req.setScheme(scheme)
//            .setHost(host)
//            .setPath(path)
//            .setCache(policy: cachePolicy)
//            .setTimeout(interval: timeoutInterval)
//            .setHeaders(headers)
//    }
//    
//    static func getRequest<Request: APIRequestable>() -> Request {
//        let req = Request()
//        req.method = .get
//        return req
//    }
}
