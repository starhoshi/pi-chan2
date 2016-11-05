//
//  Toaster+Extension.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import Toaster

extension Delay {
    public static let SuperLongDelay: TimeInterval = 5.0
}

extension Toast {
    static func showLong(text: String) {
        ToastCenter.default.cancelAll()
        ToastConfigrations.initSettings()
        // Toast.makeText(text, duration: Delay.SuperLongDelay).show()
        Toast(text: text, duration: Delay.long).show()
    }
}

class ToastConfigrations {
    static func initSettings() {
        ToastView.appearance().backgroundColor = UIColor.esaBrown
        ToastView.appearance().textColor = UIColor.esaFontBlue
        ToastView.appearance().font = R.font.latoRegular(size: 15)
        ToastView.appearance().bottomOffsetPortrait = 100
    }
}
