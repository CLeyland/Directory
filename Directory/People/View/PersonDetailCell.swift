//
//  PersonDetailCell.swift
//  Directory
//
//  Created by Chris on 13/02/2022.
//

import Foundation
import UIKit

/// Subtitle cell style subclass to show Person properties based
/// on the PersonViewModel.displayField specified
class PersonDetailCell: UITableViewCell {
    var person: Person?
    var displayItem: PersonViewModel.displayField?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(for person: Person, displaying displayItem: PersonViewModel.displayField) {
        self.person = person
        self.displayItem = displayItem
        
        selectionStyle = .none

        textLabel?.font = .preferredFont(forTextStyle: .caption1)
        detailTextLabel?.textColor = .VirginMoney.primary
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        guard
            let displayItem = displayItem,
            let person = person
        else {
            return
        }

        textLabel?.text = displayItem.tite()
        detailTextLabel?.text = displayItem.value(person: person)
    }
}
