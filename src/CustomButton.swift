//
//  CustomButton.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/18.
//  Copyright © 2016年 Satoshi Ogata. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setup() {
        layer.cornerRadius = 4.0
        layer.masksToBounds = true
        layer.borderColor = UIColor.appBorderColor().cgColor
        layer.borderWidth = 1.0

        setTitleColor(UIColor.white, for: UIControlState())
        setBackgroundImage(imageWithColor(UIColor.appColor()), for: UIControlState())
        setBackgroundImage(imageWithColor(UIColor.appHighlightColor()), for: UIControlState.highlighted)
    }

    fileprivate func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}
