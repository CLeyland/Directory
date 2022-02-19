//
//  PeopleSplitViewController.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation
import UIKit

/// Split view controller to act as container for the Person Search & Person Detail views
public class PeopleSplitViewController: UISplitViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Set to allVisible so search view doesnt start of screen
        preferredDisplayMode = .allVisible

        delegate = self

        // The contcts View will contain 2 views:
        //  - PeopleSearchViewController: To search the API for People
        //  - PersonDetailViewController: To show the details of the selected Person
        //
        // These will be the Primary & Details views of this UISplitViewController

        // Create primary View (PeopleSearchViewController)
        // and a navigation controller to hold it and host its seach controllers searchbar
        let peopleSearchViewController = PeopleSearchViewController(style: .plain)
        let peopleSearchNavigationController = UINavigationController(rootViewController: peopleSearchViewController)

        // Create the split views details view to show Peoples details.
        // PeopleSearchViewController will send delegate messages to update this view when a person is selected
        let personDetailViewController: PersonDetailViewController
        if #available(iOS 13.0, *) {
            personDetailViewController = PersonDetailViewController(style: .insetGrouped)
        } else {
            personDetailViewController = PersonDetailViewController(style: .plain)
        }

        // Assign delegate so we can update PeopleSearchViewController when we select a Person
        peopleSearchViewController.delegate = personDetailViewController

        // Add the views to this split view controller
        viewControllers = [peopleSearchNavigationController, personDetailViewController]
    }
}

extension PeopleSplitViewController: UISplitViewControllerDelegate {
    // Overide default Splitview controlle rbehaviour so the primary (search controller)
    // is displayed by default on startup
    // Need both versions below to cover < iOS 14 & iOS 14+ where behavior changed
    public func splitViewController(_ splitViewController: UISplitViewController,
                                    collapseSecondary secondaryViewController: UIViewController,
                                    onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }

    @available(iOS 14.0, *)
    public func splitViewController(_ svc: UISplitViewController,
                                    topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
}
