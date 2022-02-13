//
//  UIColor+Extensions.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation
import UIKit

/// Extension providing convinient access Virgin Media brand colours
extension UIColor {
    /// Organisation Struct to hold custom colours from the Virgin Mone ybrand
    struct VirginMoney {
        /// Virgin Money primary brand colour
        static var primary: UIColor {
            .VirginMoney.red
        }

        /// Virgin Money brand red
        static let red = UIColor(red: 196 / 255, green: 2 / 255, blue: 2 / 255, alpha: 1)
    }
}
