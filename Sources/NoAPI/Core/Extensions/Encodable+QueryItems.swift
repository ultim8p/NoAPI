//
//  Encodable+QueryItems.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public extension Encodable {
    
    func queryItems(using encoder: JSONEncoder? = nil) throws -> [URLQueryItem]? {
        guard let dictionary = try dictionary(using: encoder) else { return nil }
        return dictionary.encodedQueryItems()
    }
}
