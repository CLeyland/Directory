//
//  File.swift
//
//
//  Created by 702041028 on 19/02/2022.
//

import Foundation
import UIKit

public extension UITableView {
    /// Check if a table view index exists before using it
    /// - Parameter indexPath: Index path to validate
    /// - Returns: Boolean indicating if it exists
    func indexPathExists(indexPath: IndexPath) -> Bool {
        if indexPath.section >= numberOfSections {
            return false
        }
        
        if indexPath.row >= numberOfRows(inSection: indexPath.section) {
            return false
        }
        
        return true
    }
}
