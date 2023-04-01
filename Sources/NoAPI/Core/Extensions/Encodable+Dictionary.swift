//
//  Encodable+Dictionary.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public extension Encodable {
    
    func dictionary(using encoder: JSONEncoder? = nil) throws -> [String: Any]? {
        let encoder = encoder ?? JSONEncoder()
        let data = try encoder.encode(self)
        let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        return dict
    }
}
