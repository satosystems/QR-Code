//
//  CustomButton.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/18.
//  Copyright © 2016年 App research and development. All rights reserved.
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

    private func setup() {
        layer.cornerRadius = 4.0
        layer.masksToBounds = true
        layer.borderColor = UIColor.appBorderColor().CGColor
        layer.borderWidth = 1.0

        setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        setBackgroundImage(imageWithColor(UIColor.appColor()), forState: UIControlState.Normal)
        setBackgroundImage(imageWithColor(UIColor.appHighlightColor()), forState: UIControlState.Highlighted)
    }

    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
