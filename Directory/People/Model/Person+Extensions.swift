//
//  Person+Extensions.swift
//  Directory
//
//  Created by Chris on 13/02/2022.
//

import Foundation
import UIKit

extension Person {
    /// File path for the cached avatar image
    /// - Returns: A path URL
    private func avatarCachePath() -> URL {
        // Get the path  to where image will/has been saved
        FileManager.default.temporaryDirectory.appendingPathComponent(email)
    }

    /// Returns a chached avatar Image, if found and a valid UIImage
    /// - Returns: A persons avatar image
    private func cachedAvatarImage() -> UIImage? {
        let path = avatarCachePath()

        // If data is found and it contains a valid image retrun the cached image
        guard
            FileManager.default.fileExists(atPath: path.relativePath),
            let imageData = try? Data(contentsOf: path),
            let avatarImage = UIImage(data: imageData)
        else {
            return nil
        }

        return avatarImage
    }

    /// Returns the persons avatar image, if not found in the cache will be downloaded and saved
    /// - Parameter completionHandler: completion handler to return the image too when retrieved
    func avatarImage(completionHandler: @escaping (UIImage?) -> Void) {
        // if we have an image in the cache return the cached copy
        if let cachedImage = cachedAvatarImage() {
            completionHandler(cachedImage)
            return
        }

        // Make sure the person avatar property contains a valid url
        guard
            let avatarURL = URL(string: avatar)
        else {
            completionHandler(nil)
            return
        }

        // Download the avatar image
        URLSession.shared.dataTask(with: avatarURL) {
            data, _, _ in

            DispatchQueue.main.async {
                // Check image is valid
                guard
                    let data = data,
                    let avatarImage = UIImage(data: data)
                else {
                    completionHandler(nil)
                    return
                }

                // Try to save the image for quick retrival later
                // as it's just a cached image we'll ignore any errors
                let path = avatarCachePath()
                try? data.write(to: path)

                // return the image
                completionHandler(avatarImage)
            }
        }.resume()
    }
}
