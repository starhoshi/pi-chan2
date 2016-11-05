//
//  SirenUpdater.swift
//  KotaichiDex
//
//  Created by Kensuke Hoshikawa on 2016/10/03.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import Siren

class SirenUpdater {
    static func checkVersion(checkType: SirenVersionCheckType) {
        let siren = Siren.sharedInstance
        siren.alertType = .option
        siren.revisionUpdateAlertType = .option
        siren.patchUpdateAlertType = .option
        siren.minorUpdateAlertType = .skip
        siren.majorUpdateAlertType = .force
        siren.checkVersion(checkType: checkType)
    }
}
