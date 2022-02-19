//
//  RootTabBarController.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import DirectoryAPI
import Foundation
import UIKit

/// Root view controller for our App
///
/// A custom UITabBarController allowing us to switch between view for our 2 API respirces
/// Tab 1 contains a UISplitViewController to search and show the details of People
/// Tab 2 show the list of Meeting rooms available
class RootTabBarController: UITabBarController {
    override func viewDidLoad() {
        // Create People tab
        let peopleTab = PeopleSplitViewController()
        let peopleTabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        peopleTab.tabBarItem = peopleTabBarItem

        // Create Rooms tab
        let roomsTab = UINavigationController(rootViewController: RoomListViewController())
        let roomsTabItem = UITabBarItem(title: NSLocalizedString("Meeting Rooms", comment: "Rooms view tab title"),
                                        image: UIImage(named: "meetingRoom"),
                                        tag: 1)
        roomsTab.tabBarItem = roomsTabItem

        // Add the 2 tabs to the tab bar
        viewControllers = [peopleTab, roomsTab]
    }
}
