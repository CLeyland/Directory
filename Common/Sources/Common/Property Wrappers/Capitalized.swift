//
//  Capitalized.swift
//  Directory
//
//  Created by Chris on 13/02/2022.
//

import Foundation

/// Ensures that the string is capitalized using the current locale.
@propertyWrapper
public struct Capitalized: Decodable {
    private var value: String = ""

    public var wrappedValue: String {
        get { value }
        set { value = newValue.localizedCapitalized }
    }

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let decodedString = try decoder.singleValueContainer().decode(String.self)
        self.wrappedValue = decodedString
    }
}
