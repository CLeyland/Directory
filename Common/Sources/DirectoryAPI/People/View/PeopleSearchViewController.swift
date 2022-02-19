//
//  PeopleSearchViewController.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation
import UIKit

/// Allows updating Person detail view when a Person search result is selected
protocol PeopleSearchViewControllerDelegate: AnyObject {
    func didSelect(person: Person) -> Void
    func splitViewDetailController() -> UIViewController
}

/// View controller to search & display results from the API Person endpoint
///
/// Thsi view serves as the UISPlitViewControllers primary view controller
class PeopleSearchViewController: UITableViewController {
    private let searchController = UISearchController(searchResultsController: nil)

    weak var delegate: PeopleSearchViewControllerDelegate?

    lazy var viewModel = {
        PeopleViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()

        navigationItem.titleView = searchController.searchBar

        viewModel.updateDataHandler = {
            [weak self] in

            guard let self = self else { return }

            self.tableView.reloadData()
        }
    }
}

// ************************************************************
// UItableView delegate & datasource methods
// ************************************************************
extension PeopleSearchViewController {
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.error != nil ? 1 : viewModel.people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        // If the search errors we'll show a cell with the loclized error
        // else show the name and job title.
        // As these are simple cells we can just use MVC - no additinal model is required
        if viewModel.error != nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "peopleSearchErrorCell")
            cell.textLabel?.text = viewModel.error?.localizedDescription
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.numberOfLines = 0
        } else {
            let person = viewModel.people[indexPath.row]

            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "peopleResultCell")
            cell.textLabel?.text = person.firstName
            cell.detailTextLabel?.text = person.jobtitle
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            !viewModel.people.isEmpty,
            viewModel.error == nil,
            let delegate = delegate
        else { return }

        delegate.didSelect(person: viewModel.people[indexPath.row])
        splitViewController?.showDetailViewController(delegate.splitViewDetailController(), sender: nil)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// ************************************************************
// UISearchController delegates methods
// ************************************************************
extension PeopleSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if !(searchController.searchBar.text?.isEmpty ?? true) {
            viewModel.searchText = searchController.searchBar.text
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // By setting searchText to nil we'll cancel any debounced action still waiting to execute
        viewModel.searchText = nil
    }
}
