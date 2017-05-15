//
//  BaseViewController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/18.
//  Copyright © 2016年 Satoshi Ogata. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let margin = CGFloat(10)
    let buttonHeight = CGFloat(50)
    let labelHeight = CGFloat(25)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteSmokeColor()
    }
}
