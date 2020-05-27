//
//  TabBarViewController.swift
//  CarNotes
//
//  Created by Michael Koohang on 3/27/20.
//  Copyright © 2020 Michael Koohang. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
               
        let homeItem = UITabBarItem()
        homeItem.title = "Home"
        homeItem.image = UIImage(systemName: "house.fill")
        
        let logItem = UITabBarItem()
        logItem.title = "Log"
        logItem.image = UIImage(systemName: "plus")
       
        let settingsItem = UITabBarItem()
        settingsItem.title = "Settings"
        settingsItem.image = UIImage(systemName: "gear")

        let homeViewController = UINavigationController(rootViewController: HomeVC())
        homeViewController.tabBarItem = homeItem
        
        let logViewController = LogVC()
        logViewController.tabBarItem = logItem
                
        let settingsViewController = UINavigationController(rootViewController: SettingsVC())
        settingsViewController.tabBarItem = settingsItem
       
        self.viewControllers = [homeViewController, logViewController, settingsViewController]
        self.selectedIndex = 0
    }

}
