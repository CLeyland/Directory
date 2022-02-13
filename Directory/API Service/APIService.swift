//
//  APIRequest.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation
import UIKit

/// Singleton API service to query MockApi.io endpoints
struct DirectoryAPIService {
    /// API host, can defaultto different host for Debug & Production builds
    /// so Debug builds default to Dev server while Production will point to Live
    private var host: String {
        #if DEBUG
            "61e947967bc0550017bc61bf.mockapi.io"
        #else
            "61e947967bc0550017bc61bf.mockapi.io"
        #endif
    }

    /// Resource endpoints of the API
    enum Resource: String {
        case people = "/api/v1/people"
        case rooms = "/api/v1/rooms"
    }

    /// Computed property to grab a URLComponents object for the API
    /// we use a URLComponents to give us a type safe way of buiding the url
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host

        return urlComponents
    }

    private init() {}

    // Shared instance of teh API srvice
    // Using a singlton so we dont have to keep making multiple
    // instances of the same class and its used constantly
    static let shared = DirectoryAPIService()

    /// Make a APi network fetch for a resurce and decod it to the requested type
    /// - Parameters:
    ///   - resource: the API endpoint/resourceto fetch
    ///   - type: the expected return type to decode to
    ///   - parameters: Query parameters for the request e.g.. search, orderby etc
    ///   - completionHandler: handler to process the fetch result
    func fetch<T: Decodable>(resource: Resource, of type: T.Type, withPrameters parameters: [String: String]? = nil,
                             completionHandler: @escaping (Result<T, Error>) -> Void) {
        // use URL components to build the url for teh API request
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

            // Pass reuslt back n main queue so we don cause UIKit issues
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
