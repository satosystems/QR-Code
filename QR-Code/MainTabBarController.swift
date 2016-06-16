//
//  MainTabBarController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let scanView = ScanViewController()
        let historiesView = HistoriesViewController()

        scanView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Search, tag: 1)  // FIXME: change icon
        historiesView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.History, tag: 2)  // FIXME: change icon

        self.setViewControllers([scanView, historiesView], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
