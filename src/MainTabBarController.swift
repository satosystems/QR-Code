//
//  MainTabBarController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let scanView = ScanViewController()
        let historiesView = HistoriesViewController()
        let navigationView = UINavigationController(rootViewController: historiesView)

        scanView.tabBarItem = UITabBarItem(title: NSLocalizedString("Scan", comment: "スキャン"), image: UIImage(named: "camera"), tag: 1)
        navigationView.tabBarItem = UITabBarItem(title: NSLocalizedString("Histories", comment: "履歴"), image: UIImage(named: "list"), tag: 2)

        setViewControllers([scanView, navigationView], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
