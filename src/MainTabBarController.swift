//
//  MainTabBarController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    class TabAnimation: NSObject, UIViewControllerAnimatedTransitioning {
        func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
            return 0.5
        }

        func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
            let from: UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let to: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            let container: UIView = transitionContext.containerView()!
            container.insertSubview(to.view, aboveSubview: from.view)
            to.view.alpha = 0.0

            UIView.animateWithDuration(transitionDuration(transitionContext),
                                       animations: {() -> Void in
                                        from.view.alpha = 0.0
                                        to.view.alpha = 1.0
                }, completion: {(finished: Bool) in
                    transitionContext.completeTransition(true)
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

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

    func tabBarController(tabBarController: UITabBarController,
                          animationControllerForTransitionFromViewController fromVC: UIViewController,
                                                                             toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        return TabAnimation()
    }
}
