//
//  URLQueryItem+Helpers.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public extension Array where Element == URLQueryItem {
    
    func dictionary() -> [String: Any]? {
        var queryDict: [String: Any] = [:]
        for item in self {
            if item.name.contains("[]") {
                let arrayKey = item.name.replacingOccurrences(of: "[]", with: "")
                if var dictArray = queryDict[arrayKey] as? [String], let value = item.value {
                    dictArray.append(value)
                    queryDict[arrayKey] = dictArray
                } else {
                    queryDict[arrayKey] = [item.value]
                }
            } else {
                if let val = item.value {
                    queryDict[item.name] = val
                }
            }
        }
        
        return queryDict.count > 0 ? queryDict : nil
    }
}
