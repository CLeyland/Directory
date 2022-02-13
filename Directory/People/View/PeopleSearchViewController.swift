//
//  PeopleSearchViewController.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation
import UIKit

protocol PeopleSearchViewControllerDelegate: AnyObject {
    func didSelect(person: Person) -> Void
    func splitViewDetailController() -> UIViewController
}

class PeopleSearchViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)

    weak var delegate: PeopleSearchViewControllerDelegate?

    lazy var viewModel = {
        PeopleViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // navigationController?.navigationBar.prefersLargeTitles = true

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
// Handle scrolling results table
// ************************************************************
// extension PeopleSearchViewController {
//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        if searchController.searchBar.isFirstResponder {
//            searchController.searchBar.resignFirstResponder()
//        }
//    }
// }

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

        if viewModel.error != nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "peopleSearchErrorCell")
            cell.textLabel?.text = viewModel.error?.localizedDescription
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.numberOfLines = 0
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "peopleResultCell")
            cell.textLabel?.text = viewModel.people[indexPath.row].firstName
            cell.detailTextLabel?.text = viewModel.people[indexPath.row].jobtitle
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
}

// ************************************************************
// UISearchController delegates methods
// ************************************************************
extension PeopleSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if !(searchController.searchBar.text?.isEmpty ?? true) {
            viewModel.currentSearch = searchController.searchBar.text
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.currentSearch = nil
    }
}
