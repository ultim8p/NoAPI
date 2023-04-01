//
//  File.swift
//  
//
//  Created by Guerson Perez on 3/21/23.
//

import Foundation

public extension APIRequestable {
    
    var bodyDictionary: [String: Any]? {
        try? body?.dictionary
    }
    
    var queryDictionary: [String: Any]? {
        queryItems?.dictionary()
    }
    
    var isQueryParametersRequest: Bool {
        method == .get || method == .put
    }
    
    var requestParameters: [String: Any]? {
        return isQueryParametersRequest ?
        queryDictionary : bodyDictionary
    }
}
