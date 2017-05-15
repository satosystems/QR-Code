//
//  MainTabBarController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 Satoshi Ogata. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    fileprivate var scanViewController: ScanViewController?
    fileprivate var historiesViewController: HistoriesViewController?

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

        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(self.reloadData),
                                                         name: NSNotification.Name(rawValue: AppDelegate.settingsChanged),
                                                         object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func reloadData() {
        let tableViewController = historiesViewController?.childViewControllers[0] as! UITableViewController
        let tableView = tableViewController.tableView
        tableView?.reloadData()
        tableView?.dataSource = tableViewController
    }
}
