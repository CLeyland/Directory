//
//  Person.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Common
import Foundation

/// Allias Object for an array of Person
typealias People = [Person]

/// Represents a Person from the People API endpoint
struct Person: Decodable {
    /// As id from the API is actually just an index we'll return the
    /// Persons email address as our Identifiable id as its unique
    /// iOS < 13 dont support Identifiable but we can add in with no
    /// change when we up supported versions
    var id: String {
        email
    }

    @Capitalized var firstName: String
    @Capitalized var lastName: String
    @Capitalized var jobtitle: String
    let email: String
    let avatar: String
    @Capitalized var favouriteColor: String

    let createdAt: Date
}
