//
//  Extensions.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/17.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    class func whiteSmokeColor() -> UIColor {
        return UIColor.rgbColor(0xF5F5F5)
    }

    class func appColor() -> UIColor {
        return UIColor.rgbColor(0x3B6BB0)
    }

    class func appHighlightColor() -> UIColor {
        return UIColor.rgbColor(0x305B98)
    }

    class func appBorderColor() -> UIColor {
        return UIColor.rgbColor(0x234B7C)
    }

    class func rgbColor(rgbValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF,
            green: CGFloat((rgbValue & 0x00FF00) >>  8) / 0xFF,
            blue:  CGFloat( rgbValue & 0x0000FF)        / 0xFF,
            alpha: CGFloat(1.0)
        )
    }
}

extension ZBarSymbolSet: SequenceType {
    public func generate() -> NSFastGenerator {
        return NSFastGenerator(self)
    }
}
