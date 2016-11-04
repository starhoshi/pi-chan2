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
        ToastView.appearance().backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        ToastView.appearance().textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ToastView.appearance().bottomOffsetPortrait = 120
    }
}
