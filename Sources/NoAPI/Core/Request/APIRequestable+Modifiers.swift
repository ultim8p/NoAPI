//
//  APIRequest+Modifiers.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation
import Mergeable

public extension APIRequestable {
    
    // MARK: - Method
    
    func setMethod(_ method: APIMethod?) throws -> Self {
        self.method = method
        return self
    }
    
    // MARK: - Path
    
    func setUrl(string: String?) throws -> Self {
        
        guard let urlString = string,
              let url = URL(string: urlString),
              let host = url.host,
              let scheme = url.scheme else {
            throw APIError.invalidUrl
        }
        
        let request = self.setHost(host).setScheme(scheme)
        guard !url.path.isEmpty else { return request }
        return request.addPath(url.path)
    }
    
    func setScheme(_ scheme: String?) -> Self {
        self.scheme = scheme
        return self
    }
    
    func setHost(_ host: String?) -> Self {
        self.host = host
        return self
    }
    
    func setPath(_ path: String?) -> Self {
        self.path = path
        return self
    }
    
    func addPath(_ path: String?) -> Self {
        guard let path = path else { return self }
        self.path = (self.path ?? "") + path
        return self
    }
    
    func setPort(_ port: Int?) -> Self {
        self.port = port
        return self
    }
    
    func setCache(policy: URLRequest.CachePolicy?) -> Self {
        self.cachePolicy = policy
        return self
    }
    
    func setTimeout(interval: TimeInterval?) -> Self {
        self.timeoutInterval = interval
        return self
    }
    
    // MARK: Headers
    
    func addHeaders(_ headers: [String: String]?) -> Self {
        guard let headers = headers else { return self }
        var newHeaders = self.headers ?? [:]
        _ = newHeaders.merge(with: headers) ?? [:]
        return setHeaders(newHeaders)
    }
    
    func setHeaders(_ headers: [String: String]?) -> Self {
        self.headers = headers
        return self
    }
    
    // MARK: Body
    
    func setBody(_ data: Data?) -> Self {
        body = data
        return self
    }
    
    func addBody(_ body: Encodable?, using encoder: JSONEncoder? = nil) throws -> Self {
        guard let body = body else { return self }
        let encoder = encoder ?? JSONEncoder()
        guard let addingDictionary = try body.dictionary(using: encoder) else { return self }
        return try addBody(addingDictionary)
    }
    
    func setBody(_ body: Encodable?, using encoder: JSONEncoder? = nil) throws -> Self {
        guard let bodyDictionary = try body?.dictionary(using: encoder) else { return self }
        return try setBody(bodyDictionary)
    }
    
    func addBody(_ body: [String: Any]?) throws -> Self {
        guard let body = body else { return self }
        if var currentDictionary = try self.body?.dictionary {
            _ = currentDictionary.merge(with: body)
            return try setBody(currentDictionary)
        } else {
            return try setBody(body)
        }
    }
    
    func setBody(_ body: [String: Any]?) throws -> Self {
        guard let body = body else { return self }
        let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .sortedKeys)
        self.body = jsonBody
        return self
    }
    
    // MARK: Query
    
    func setQuery(object: Encodable?, using encoder: JSONEncoder? = nil) throws -> Self {
        return setQuery(dictionary: try object?.dictionary(using: encoder))
    }
    
    func addQuery(object: Encodable?, using encoder: JSONEncoder? = nil) throws -> Self {
        return addQuery(dictionary: try object?.dictionary(using: encoder))
    }
    
    func addQuery(items: [URLQueryItem]?) -> Self {
        return addQuery(dictionary: items?.dictionary())
    }
    
    func setQuery(items: [URLQueryItem]?) -> Self {
        return setQuery(dictionary: items?.dictionary())
    }
    
    func addQuery(dictionary: [String: Any]?) -> Self {
        guard let items = dictionary else { return self }
        if var currentDictionary = queryItems?.dictionary() {
            _ = currentDictionary.merge(with: items)
            return setQuery(dictionary: currentDictionary)
        } else {
            return setQuery(dictionary: items)
        }
    }
    
    func setQuery(dictionary: [String: Any]?) -> Self {
        self.queryItems = dictionary?.queryItems()
        return self
    }
}
