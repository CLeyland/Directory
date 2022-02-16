//
//  Room.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation

/// Allias Object for and array of Rooms
public typealias Rooms = [Room]

/// Represents a Room from the Rooms API endpoint
public struct Room: Decodable {
    public let id: String

    public let isOccupied: Bool
    public let maxOccupancy: Int

    public let createdAt: Date
}
