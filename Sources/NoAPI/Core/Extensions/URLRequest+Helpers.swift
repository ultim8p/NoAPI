//
//  URLRequest+Helpers.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

extension URLRequest {
    
    mutating func addHeaders(_ headers: [String: String]?) {
        for (key, value) in headers ?? [:] {
            addValue(value, forHTTPHeaderField: key)
        }
    }
}
