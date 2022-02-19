//
//  PersonDetailViewController.swift
//  Directory
//
//  Created by Chris on 13/02/2022.
//

import Foundation
import UIKit

/// View controller to show the persons detail properties
///
/// This view serves as the UISplitViewControllers detail view
class PersonDetailViewController: UITableViewController, PeopleSearchViewControllerDelegate {
    lazy var viewModel = {
        PersonViewModel(person: nil)
    }()

    override func viewDidLoad() {
        if viewModel.person == nil {
            tableView.isHidden = true
        }

        // register our custom detail cells for reuse
        tableView.register(PersonDetailHeaderCell.self, forCellReuseIdentifier: "personHeaderCell")
        tableView.register(PersonDetailCell.self, forCellReuseIdentifier: "personDetailCell")
    }

    func didSelect(person: Person) {
        viewModel = PersonViewModel(person: person)

        tableView.isHidden = false
        tableView.reloadData()
    }

    func splitViewDetailController() -> UIViewController {
        self
    }
}

// ************************************************************
// UItableView delegate & datasource methods
// ************************************************************
extension PersonDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int { 2 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : PersonViewModel.displayField.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard
                let person = viewModel.person,
                PersonViewModel.displayField.init(rawValue: indexPath.row) != nil,
                let headerCell = tableView.dequeueReusableCell(withIdentifier: "personHeaderCell") as? PersonDetailHeaderCell
            else {
                return UITableViewCell()
            }

            // Configure the cell to show this persons details
            headerCell.configure(for: person)

            return headerCell

        } else {
            guard
                let person = viewModel.person,
                let displayItem = PersonViewModel.displayField.init(rawValue: indexPath.row),
                let detailCell = tableView.dequeueReusableCell(withIdentifier: "personDetailCell") as? PersonDetailCell
            else {
                return UITableViewCell()
            }

            // Configure the detail cell for the person to diplay the selected attribute of the person
            // based on the enum
            detailCell.configure(for: person, displaying: displayItem)

            return detailCell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if
            indexPath.section == 1 && indexPath.row == 0,
            let email = viewModel.person?.email,
            let mailTo = URL(string: "mailto:\(email)"),
            UIApplication.shared.canOpenURL(mailTo) {
            UIApplication.shared.open(mailTo, options: [:], completionHandler: nil)
        }
    }
}
