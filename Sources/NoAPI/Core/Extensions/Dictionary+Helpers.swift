//
//  Dictionary+Helpers.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public extension [String: Any] {
    
    func queryItems() -> [URLQueryItem]? {
        let keys = keys.sorted(by: <)
        var items: [URLQueryItem] = []
        for i in 0..<keys.count {
            if let arrayValue = self[keys[i]] as? [String] {
                for x in 0..<arrayValue.count {
                    let value = arrayValue[x]
                    items.append(URLQueryItem(name: "\(keys[i])[]",
                                              value: value))
                }
            } else if let dictValue = self[keys[i]] as? [String: Any] {
                for (key, val) in dictValue {
                    items.append(URLQueryItem(name: "\(keys[i])[\(key)]",
                                              value: String(describing: val)))
                }
            } else {
                guard let value = self[keys[i]] else { continue }
                let stringValue = String(describing: value)
                items.append(URLQueryItem(name: keys[i], value: stringValue))
            }
        }
        
        return items.count > 0 ? items : nil
    }
    
    func encodedQueryItems() -> [URLQueryItem]? {
        let keys = keys.sorted(by: <)
        var items: [URLQueryItem] = []
        for i in 0..<keys.count {
            if let arrayValue = self[keys[i]] as? [String] {
                for x in 0..<arrayValue.count {
                    let value = arrayValue[x]
                    items.append(URLQueryItem(name: "\(keys[i])[]".URLEncoded,
                                              value: value.URLEncoded))
                }
            } else if let dictValue = self[keys[i]] as? [String: Any] {
                for (key, val) in dictValue {
                    items.append(URLQueryItem(name: "\(keys[i])[\(key)]".URLEncoded,
                                              value: String(describing: val).URLEncoded))
                }
            } else {
                guard let value = self[keys[i]] else { continue }
                let stringValue = String(describing: value)
                items.append(URLQueryItem(name: keys[i].URLEncoded, value: stringValue.URLEncoded))
            }
        }
        
        return items.count > 0 ? items : nil
    }
}
