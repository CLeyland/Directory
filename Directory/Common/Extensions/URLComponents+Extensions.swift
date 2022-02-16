//
//  URLComponents.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation

public extension URLComponents {
    /// Convinience function to add query parameters to a url ensuring valid syntax
    /// 
    /// - Parameter parameters: Key, Value pairs to add as url query items,
    ///                         setting parameters to nil will remove all parameters
    mutating func setQueryItems(with parameters: [String: String]?) {
        if let parameters = parameters {
            queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        } else {
            queryItems?.removeAll()
        }
    }
}
