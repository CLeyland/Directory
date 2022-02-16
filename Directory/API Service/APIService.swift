//
//  APIRequest.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation
import UIKit

/// Singleton API service to query MockApi.io Directory endpoints
///
/// Access via the ``shared`` propery
public struct DirectoryAPIService {
    /// The API host
    ///
    /// Will default to different host for Debug & Production builds
    /// so Debug builds default to Dev server while Production will point to Live
    private var host: String {
        #if DEBUG
            "61e947967bc0550017bc61bf.mockapi.io"
        #else
            "61e947967bc0550017bc61bf.mockapi.io"
        #endif
    }

    /// Resource endpoints for the Directory API
    public enum Resource: String {
        case people = "/api/v1/people"
        case rooms = "/api/v1/rooms"
    }

    /// Computed property used to construct valid urls for API resource requests
    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host

        return urlComponents
    }

    private init() {}

    /// Shared instance of the API srvice
    ///
    /// A singlton is used to prevent storing multiple
    /// instances of the same class due to its high usage
    public static let shared = DirectoryAPIService()

    /// Make an APi fetch request for a given resource and attempt decode to the requested type
    ///
    /// - Parameters:
    ///   - resource: The API endpoint/resource to fetch
    ///   - type: The expected return type to decode to
    ///   - parameters: Query parameters for the request e.g. search, orderby etc
    ///   - completionHandler: Completion handler to process the fetch result
    public func fetch<T: Decodable>(resource: Resource, of type: T.Type,
                                    withPrameters parameters: [String: String]? = nil,
                                    completionHandler: @escaping (Result<T, Error>) -> Void) {
        // Use URL components to build the url for the API request
        var components = urlComponents
        components.path = resource.rawValue
        components.setQueryItems(with: parameters)

        // Make sure we have a valid url
        // if we dont have a valid url send a badURL error
        guard
            let url = components.url
        else {
            completionHandler(.failure(URLError(.badURL)))
            return
        }

        // Make the request and attempt to atomatically decode the response
        URLSession.shared.decodedDataTask(with: url, of: type.self) {
            decodedData, _, error in

            // Pass reuslt back on main queue so we don cause UIKit issues
            DispatchQueue.main.async {
                // Hide network activity icon
                UIApplication.shared.isNetworkActivityIndicatorVisible = false

                if let decodedData = decodedData {
                    completionHandler(.success(decodedData))
                    return
                }

                if let error = error {
                    completionHandler(.failure(error))
                    return
                }
            }
        }.resume()

        // Show network activity indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}
