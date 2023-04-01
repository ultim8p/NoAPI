//
//  Data+Extensions.swift
//  
//
//  Created by Guerson Perez on 3/21/23.
//

import Foundation

public extension Data {
    
    var jsonObject: Any? {
        get throws {
            return try JSONSerialization.jsonObject(with: self)
        }
    }
    
    var dictionary: [String: Any]? {
        get throws {
            return try jsonObject as? [String : Any]
        }
    }
}
