//
//  URLQueryItem+API.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public extension Array where Element == URLQueryItem {
    
    func get<Request: APIRequestable>(
        scheme: String? = nil,
        host: String? = nil,
        path: String? = nil,
        cachePolicy: URLRequest.CachePolicy? = nil,
        timeoutInterval: TimeInterval? = nil,
        headers: [String: String]? = nil
    ) -> Request {
        let req = Request()
        return req.setScheme(scheme)
            .setHost(host)
            .setPath(path)
            .setCache(policy: cachePolicy)
            .setTimeout(interval: timeoutInterval)
            .setHeaders(headers)
            .setQuery(items: self)
    }
}
