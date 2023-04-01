//
//  APIResponse+Value.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public extension APIResponse {
    
    @MainActor
    func optionalValue<Response: Codable>(
        decoder: JSONDecoder? = nil
    ) throws -> Response? {
        guard let data = data,
                !data.isEmpty else { return nil }
        let type = Response.self
        let decoder = decoder ?? JSONDecoder()
        let responseObject = try decoder.decode(type, from: data)
        return responseObject
    }
    
    @MainActor
    func value<Response: Codable>(
        decoder: JSONDecoder? = nil
    ) throws -> Response {
        let response: Response? = try optionalValue(decoder: decoder)
        guard let response = response else { throw APIError.emptyResponse }
        return response
    }
}
