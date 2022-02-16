//
//  URLSession+Extensions.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation

public extension URLSession {
    /// Creates a task that retrieves the contents of the specified URL,
    /// attempts to decode it to the requested type, then calls a handler upon completion.
    ///
    /// - Parameters:
    ///   - type: Type to decode the JSON too when response received
    ///   - request: A URL request object that provides the URL, cache policy, request type, body data or body stream, and so on.
    ///   - completionHandler: The completion handler to call when the load request is complete.
    ///
    /// - Returns: URLSessionDataTask
    func decodedDataTask<T: Decodable>(with url: URL, of type: T.Type, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: url) {
            data, response, error in

            // Check we have data returned, if not just retrun other parameters
            if let data = data {
                do {
                    // 1. Get our decodable object
                    let decodableType = type.self

                    // 2. try and create a new object of our requested type using
                    // the JSON data we got back from the request
                    let decodedType = try decodableType.init(fromJSON: data)

                    // 3. Return the decoded object and the response
                    completionHandler(decodedType, response, nil)
                } catch {
                    // If the init from JSON fails return the JSONDecode error
                    completionHandler(nil, response, error)
                }
            } else {
                // Request failed
                completionHandler(nil, response, error)
            }
        }
    }
}
