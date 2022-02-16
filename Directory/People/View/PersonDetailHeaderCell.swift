//
//  PersonDetailHeaderCell.swift
//  Directory
//
//  Created by Chris on 13/02/2022.
//

import Foundation
import UIKit

/// Subtitle cell style subclass to show Persons
/// avatar, name & job title
class PersonDetailHeaderCell: UITableViewCell {
    var person: Person?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configure the cells fileds based on the details of the provided Person
    /// - Parameter person: Persons details to show
    func configure(for person: Person) {
        self.person = person

        selectionStyle = .none

        textLabel?.font = .preferredFont(forTextStyle: .headline)
        textLabel?.numberOfLines = 0

        detailTextLabel?.font = .preferredFont(forTextStyle: .subheadline)
        detailTextLabel?.numberOfLines = 0

        // use a default avatar image until proper one is returned
        imageView?.image = UIImage(named: "defaultAvatar")
        imageView?.frame.size = CGSize(width: 128, height: 128)
        imageView?.layer.cornerRadius = 8
        imageView?.layer.masksToBounds = true

        // Load avatar image when we get it back, if its not cached this could take a second
        person.avatarImage {
            [weak self]
            image in

            guard let self = self else { return }

            self.imageView?.image = image
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel?.text = "\(person?.firstName ?? "")\n\(person?.lastName ?? "")"
        detailTextLabel?.text = person?.jobtitle ?? ""
    }
}
