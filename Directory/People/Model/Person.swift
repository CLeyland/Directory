//
//  Person.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation

/// Allias Object for and array of Person
public typealias People = [Person]

/// Represents a Person from the People API endpoint
public struct Person: Decodable, Identifiable {
    /// As id from the API is actually just an index we'll return the
    /// Persons email address as our Identifiable id as its unique
    public var id: String {
        email
    }

    public let firstName: String
    public let lastName: String
    public let jobtitle: String
    public let email: String
    public let avatar: String
    public let favouriteColor: String

    public let createdAt: Date
}
