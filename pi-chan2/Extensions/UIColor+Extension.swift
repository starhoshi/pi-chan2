//
//  UIColor+Extension.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public static let esaGreen = UIColor.init(hexString: "#0a9b94")!
    public static let esaBrown = UIColor.init(hexString: "#efede0")!
    public static let esaFontBlue = UIColor.init(hexString: "#3c4a60")!
    public static let grayUITextFieldBorderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    public static let skyblue = UIColor.init(hexString: "#78B9FF")!
}

extension UIColor {
    convenience init(hex16: UInt16) {
        let alpha = CGFloat((hex16 >> 12) & 0xf) / 0xf
        let red = CGFloat((hex16 >> 8) & 0xf) / 0xf
        let green = CGFloat((hex16 >> 4) & 0xf) / 0xf
        let blue = CGFloat(hex16 & 0xf) / 0xf
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    convenience init(hex32: UInt32) {
        let alpha = CGFloat((hex32 >> 24) & 0xff) / 0xff
        let red = CGFloat((hex32 >> 16) & 0xff) / 0xff
        let green = CGFloat((hex32 >> 8) & 0xff) / 0xff
        let blue = CGFloat(hex32 & 0xff) / 0xff
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    convenience init?(hexString: String) {
        if !hexString.hasPrefix("#") {
            return nil
        }
        var hexStr = hexString
        hexStr.remove(at: hexStr.startIndex)
        switch hexStr.characters.count {
        case 3:
            hexStr = "f" + hexStr
            fallthrough
        case 4:
            guard let hex16 = UInt16(hexStr, radix: 16) else {
                return nil
            }
            self.init(hex16: hex16)
        case 6:
            hexStr = "ff" + hexStr
            fallthrough
        case 8:
            guard let hex32 = UInt32(hexStr, radix: 16) else {
                return nil
            }
            self.init(hex32: hex32)
        default:
            return nil
        }
    }
}
