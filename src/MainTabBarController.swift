//
//  MainTabBarController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    private var scanViewController: ScanViewController?
    private var historiesViewController: HistoriesViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        scanViewController = ScanViewController()
        historiesViewController = HistoriesViewController()
        let navigationViewController = UINavigationController(rootViewController: historiesViewController!)

        scanViewController!.tabBarItem =
            UITabBarItem(title: NSLocalizedString("Scan", comment: "スキャン"),
                         image: UIImage(named: "camera"),
                         tag: 1)
        navigationViewController.tabBarItem =
            UITabBarItem(title: NSLocalizedString("Histories", comment: "履歴"),
                         image: UIImage(named: "list"),
                         tag: 2)

        setViewControllers([scanViewController!, navigationViewController], animated: false)

        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.reloadData),
                                                         name: AppDelegate.settingsChanged,
                                                         object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func reloadData() {
        let tableViewController = historiesViewController?.childViewControllers[0] as! UITableViewController
        let tableView = tableViewController.tableView
        tableView.reloadData()
        tableView.dataSource = tableViewController
    }
}
