//
//  PersonViewModel.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation

/// Model for the PeopleSearchViewController
class PersonViewModel {
    /// The person for this view model
    let person: Person?

    /// List of properties that can be displayed for the person
    ///
    /// Used to configure the PersonDetailCell
    enum displayField: Int, CaseIterable {
        case email
        case color
        case joined

        /// Provides the cell title text for the property
        /// - Returns: Title string
        func tite() -> String {
            switch self {
            case .email:
                return NSLocalizedString("Email", bundle: .module, comment: "Email detail cell title")
            case .color:
                return NSLocalizedString("Favourite colour", bundle: .module, comment: "Favourite colour detail cell title")
            case .joined:
                return NSLocalizedString("Joined", bundle: .module, comment: "Joined detail cell title")
            }
        }

        /// Provides the frmatted vaue for the property
        /// - Parameter person: The person to get the roperty from
        /// - Returns: Person property value
        func value(person: Person) -> String {
            switch self {
            case .email:
                return person.email
            case .color:
                return person.favouriteColor
            case .joined:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
                return dateFormatter.string(from: person.createdAt)
            }
        }
    }

    init(person: Person?) {
        self.person = person
    }
}
