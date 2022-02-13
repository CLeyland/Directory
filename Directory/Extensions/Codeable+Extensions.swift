//
//  Codeable+Extensions.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation

public extension Decodable {
    /// Create a new object from a JSON representation
    /// - Parameter fromJSON: JSON string as Data
    /// - Throws: JSONDecoder decode error
    init(fromJSON jsonData: Data, dateDecodingStratergy: JSONDecoder.DateDecodingStrategy? = nil) throws {
        let decoder = JSONDecoder()

        // Default dateDecodingStrategy .iso8601 doesn't support fractional secods so
        // we'll set a custm decode stratergy that sets the withFractionalSeconds option
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let data = try decoder.singleValueContainer().decode(String.self)

            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            return formatter.date(from: data) ?? Date()
        })

        self = try decoder.decode(Self.self, from: jsonData)
    }
}
