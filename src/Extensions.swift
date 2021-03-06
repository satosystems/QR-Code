//
//  Extensions.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/17.
//  Copyright © 2016年 Satoshi Ogata. All rights reserved.
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

    class func rgbColor(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF,
            green: CGFloat((rgbValue & 0x00FF00) >>  8) / 0xFF,
            blue:  CGFloat( rgbValue & 0x0000FF)        / 0xFF,
            alpha: CGFloat(1.0)
        )
    }
}

extension Sequence where Iterator.Element: Equatable {
    public func uniq() -> [Iterator.Element] {
        var result: [Iterator.Element] = []
        for element in self {
            if !result.contains(element) {
                result.append(element)
            }
        }
        return result
    }
}

extension ZBarSymbolSet: Sequence {
    public func makeIterator() -> NSFastEnumerationIterator {
        return NSFastEnumerationIterator(self)
    }
}
