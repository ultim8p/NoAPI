//
//  APIError.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public enum APIError: Error, CustomDebugStringConvertible, CustomStringConvertible {
    
    case invalidUrl
    case failedToEncodeParameters(_ error: Error)
    case failedToDecodeResponse(_ error: Error)
    case invalidResponseCode
    case statusCode(_ code: Int)
    case emptyResponse
    
    public var debugDescription: String {
        return description
    }
    
    public var description: String {
        switch self {
        case .invalidUrl:
            return "Invalid url"
        case .failedToEncodeParameters(let error):
            return "Failed to encode parameters \(error.localizedDescription)"
        case .failedToDecodeResponse(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .invalidResponseCode:
            return "Invalid response code"
        case .statusCode(let code):
            return "Status code: \(code)"
        case .emptyResponse:
            return "Empty response"
        }
    }
}
