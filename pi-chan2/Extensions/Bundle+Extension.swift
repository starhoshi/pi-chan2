//
//  Bundle+Extension.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation

extension Bundle {
    static func appVersion() -> String? {
        return main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
