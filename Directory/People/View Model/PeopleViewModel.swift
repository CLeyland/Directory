//
//  PeopleViewModel.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation

/// Model for the PeopleSearchViewController
class PeopleViewModel {
    /// Convinience accessor for the API service
    private var apiService: DirectoryAPIService {
        DirectoryAPIService.shared
    }

    /// Data Model for the People view, used to hold search results
    /// and populate table
    var people = People()
    var error: Error?

    /// Update handler called when people property is updated to refresh display
    var updateDataHandler: (() -> Void)?

    /// Search string, Debounced so that we dont make a request for every letter typed
    /// Debounce code will wait for no activity for duration befre call is made
    @Debounced(0.4) var searchText: String?

    init() {
        // Debounce action to take when search string is updated
        _searchText.on(action: {
            [weak self]
            searchString in

            guard let self = self else { return }

            self.search(for: searchString)
        })
    }

    /// Searchs the People API resource and stores the result in people property
    /// - Parameter searchString: String to search by, will search all fields
    private func search(for searchString: String) {
        guard !searchString.isEmpty else { return }

        let stub = """
         [{"createdAt":"2022-01-24T17:02:23.729Z","firstName":"Maggie","avatar":"https://randomuser.me/api/portraits/women/21.jpg","lastName":"Brekke","email":"Crystel.Nicolas61@hotmail.com","jobtitle":"Future Functionality Strategist","favouriteColor":"pink","id":"1"}]
        """.data(using: .utf8)

        people = try! People(fromJSON: stub!)

        if let reloadAction = updateDataHandler {
            reloadAction()
        }

        return

//        apiService.fetch(resource: .people, of: People.self, withPrameters: ["search": searchString]) {
//            [weak self]
//            result in
//
//            // Make sure we still exist
//            guard let self = self else { return }
//
//            // Check the result of the API fetch and see if it was a succes or failure
//            // depeding on result save either the People or the error
//            switch result {
//            case let .success(people):
//                self.people = people
//                self.error = nil
//
//            case let .failure(error):
//                self.people = People()
//                self.error = error
//            }
//
//            // We finished the fetch so update the table
//            if let updateDataHandler = self.updateDataHandler {
//                updateDataHandler()
//            }
//        }
    }
}
