//
//  APIResponse+Validation.swift
//  BotNotes
//
//  Created by Guerson Perez on 3/9/23.
//

import Foundation

public extension APIResponse {
    
    func validate<ErrorType: DecodableError>(
        type: ErrorType.Type? = nil,
        decoder: JSONDecoder? = nil,
        validStatusCodes: ClosedRange<Int>? = nil
    ) throws -> Self {
        guard let code = statusCode else { throw APIError.invalidResponseCode }
        let validCodes = validStatusCodes ?? 200...299
        guard validCodes.contains(code) else {
            guard let data = data,
                  !data.isEmpty,
                  let type = type else { throw APIError.statusCode(code) }
            let decoder = decoder ?? JSONDecoder()
            throw try decoder.decode(type, from: data)
        }
        return self
    }
}
