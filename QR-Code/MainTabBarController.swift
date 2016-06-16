//
//  MainTabBarController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        let scanView = ScanViewController()
        let historiesView = HistoriesViewController()

        scanView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Search, tag: 1)  // FIXME: change icon
        historiesView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.History, tag: 2)  // FIXME: change icon

        self.setViewControllers([scanView, historiesView], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        let selectedIndex = tabBarController.selectedIndex
        let toIndex = (selectedIndex + 1) % 2
        let fromViewController = tabBarController.viewControllers![selectedIndex]
        let fromView = fromViewController.view
        let toView = viewController.view;

        // Get the size of the view area.
        let scrollRight = toIndex > tabBarController.selectedIndex

        // Add the to view to the tab bar view.
        fromView.superview!.addSubview(toView)

        // Position it off screen.
        toView.frame.origin.x = scrollRight ? toView.frame.width : -toView.frame.width

        UIView.animateWithDuration(0.3,
                                   animations: {() -> Void in
                                    // Animate the views on and off the screen. This will appear to slide.
                                    fromView.frame.origin.x = scrollRight ? -toView.frame.width : toView.frame.width
                                    toView.frame.origin.x = 0
            }, completion:{(finished: Bool) -> Void in
                if (finished) {
                    // Remove the old view from the tabbar view.
                    fromView.removeFromSuperview()
                    tabBarController.selectedIndex = toIndex;
                }
        })
        return false
    }
}
