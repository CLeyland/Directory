//
//  RoomListViewController.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation
import UIKit

/// View controller to search & display results from the API Rooms endpoint
///
/// Thsi view serves as the UISPlitViewControllers primary view controller
class RoomListViewController: UITableViewController {
    private lazy var filterSegmentedControl = UISegmentedControl(items: RoomsViewModel.occupancyState.allCases.map { $0.title() })

    lazy var viewModel = {
        RoomsViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        filterSegmentedControl.sizeToFit()
        filterSegmentedControl.selectedSegmentIndex = 0
        filterSegmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        navigationItem.titleView = filterSegmentedControl

        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)

        viewModel.updateDataHandler = {
            [weak self] in

            guard let self = self else { return }

            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }

        // On 1st load set filter to unoccupied to grab a new data set from API
        viewModel.occupancyFilter = .unoccupied
    }

    @objc private func segmentedValueChanged(_ sender: UISegmentedControl) {
        // When selected segment changes set the view models occupancyFilter value to trigger a fetch and ui update
        viewModel.occupancyFilter = RoomsViewModel.occupancyState.init(rawValue: sender.selectedSegmentIndex)
    }

    @objc func refresh(_ sender: AnyObject) {
        // When user pulls to refresh set occupancyState to current seleted index again to force a new fetch
        viewModel.occupancyFilter = RoomsViewModel.occupancyState.init(rawValue: filterSegmentedControl.selectedSegmentIndex)
    }
}

// ************************************************************
// UItableView delegate & datasource methods
// ************************************************************
extension RoomListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rooms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        // If the filter errors we'll show a cell with the loclized error
        // else show the room name (id as we have no name) and the maxOccupancy and occupancy status
        // As these are simple cells we can just use MVC - no additinal model is required
        if viewModel.error != nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "roomFilterErrorCell")
            cell.textLabel?.text = viewModel.error?.localizedDescription
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.numberOfLines = 0
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "roomDetailsCell")
            cell.textLabel?.text = "Room \(viewModel.rooms[indexPath.row].id)"

            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.text =
                "Max Occupancy: \(viewModel.rooms[indexPath.row].maxOccupancy)\n\(viewModel.rooms[indexPath.row].isOccupied ? "Occupied" : "Unoccupied")"

            cell.imageView?.image = UIImage(named: viewModel.rooms[indexPath.row].isOccupied ? "occupied" : "unoccupied")
            cell.imageView?.tintColor = .VirginMoney.primary
        }

        return cell
    }
}
