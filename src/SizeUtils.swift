//
//  SizeUtils.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/17.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

struct SizeUtils {
    static func bounds() -> CGRect {
        return UIScreen.main.bounds
    }

    static func screenWidth() -> CGFloat {
        return bounds().size.width
    }

    static func screenHeight() -> CGFloat {
        return bounds().size.height
    }

    static func statusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    static func navigationBarHeight(_ navigationController: UINavigationController) -> CGFloat {
        return navigationController.navigationBar.frame.size.height
    }

    static func tabBarHeight(_ tabBarController: UITabBarController) -> CGFloat {
        return tabBarController.tabBar.frame.size.height
    }
}
