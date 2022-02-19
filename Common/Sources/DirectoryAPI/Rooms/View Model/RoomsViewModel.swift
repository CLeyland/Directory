//
//  RoomsViewModel.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Common
import Foundation

/// Model for the RoomViewController
class RoomsViewModel {
    /// Convinience accessor for the API service
    private var apiService: DirectoryAPIService {
        DirectoryAPIService.shared
    }

    /// Data Model for the Rooms view, used to hold the room list
    /// and populate table
    var rooms = Rooms()
    var error: Error?

    /// Update handler called when people is updated to refresh display
    var updateDataHandler: (() -> Void)?

    /// Enum of possible occupancy states to filter by
    enum occupancyState: Int, CaseIterable {
        case unoccupied
        case occupied
        case all

        /// Title for each occupancy state used for UI Controls
        /// - Returns: Ocupancy state title
        func title() -> String {
            switch self {
            case .all:
                return NSLocalizedString("All", bundle: .module, comment: "Room filter All title")
            case .occupied:
                return NSLocalizedString("Occupied", bundle: .module, comment: "Room filter Occupied title")
            case .unoccupied:
                return NSLocalizedString("Unoccupied", bundle: .module, comment: "Room filter unocupied title")
            }
        }

        /// Filter value for each occupancy state
        /// - Returns: Value to use in API search by query
        func filterValue() -> String? {
            switch self {
            case .all:
                return nil
            case .occupied:
                return "true"
            case .unoccupied:
                return "false"
            }
        }
    }

    /// Search string, Debounced so that we dont make a request for every key
    /// Debounce code will wait for no activity for duration before call is made
    @Debounced(0.4) var occupancyFilter: occupancyState?

    init() {
        // Debounce action to take when the filter is changed
        _occupancyFilter.on(action: {
            [weak self]
            occupiedState in

            guard let self = self else { return }

            self.filter(occupied: occupiedState)
        })
    }

    /// Filter the room list based on occupancy status
    /// - Parameter occupied: Bolean indicating occupancy filter status
    func filter(occupied: occupancyState) {
        let parameters: [String: String] = ["isOccupied": occupied.filterValue()].compactMapValues { $0 }

        apiService.fetch(resource: .rooms, of: Rooms.self, withPrameters: parameters) {
            [weak self]
            result in

            // Make sure we still exist
            guard let self = self else { return }

            // Check the result of the API fetch and see if it was a succes or failure
            // depeding on result save either the People or the error
            switch result {
            case let .success(rooms):
                self.rooms = rooms
                self.error = nil

            case let .failure(error):
                self.rooms = Rooms()
                self.error = error
            }

            // We finished the fetch so update the table
            if let updateDataHandler = self.updateDataHandler {
                updateDataHandler()
            }
        }
    }
}
