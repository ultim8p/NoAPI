//
//  String+Helpers.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

extension String {
    
    var URLEncoded: String {
        
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        var encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        encodedString = encodedString?.replacingOccurrences(of: "~", with: "%7E")
        encodedString = encodedString?.replacingOccurrences(of: "/", with: "%2F")
        encodedString = encodedString?.replacingOccurrences(of: " ", with: "+")
        encodedString = encodedString?.replacingOccurrences(of: ",", with: "%2C")
        encodedString = encodedString?.replacingOccurrences(of: "}", with: "%7D")
        
        return encodedString ?? self
    }
}
