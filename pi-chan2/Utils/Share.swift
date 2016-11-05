//
//  Share.swift
//  KotaichiDex
//
//  Created by Kensuke Hoshikawa on 2016/10/05.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import UIKit

class Share {
    static func openBrowser(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }

    static func openAppStore(_ url: URL) {
        UIApplication.shared.openURL(url)
    }

    static func showAppShareActivityView() {
        let shareText = "ピーちゃん 〜 esa.io の iOS クライアント"
        let shareWebsite = Constants.Pichan.Url.iTunes.getITunes()
        let activityItems: [Any] = [shareText, shareWebsite]

        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let excludedActivityTypes = [
            UIActivityType.postToWeibo,
            UIActivityType.saveToCameraRoll,
            UIActivityType.print,
            UIActivityType.mail,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.airDrop,
            UIActivityType.openInIBooks,
            UIActivityType.assignToContact,
            UIActivityType.postToTencentWeibo
        ]
        activityVC.excludedActivityTypes = excludedActivityTypes
        UIApplication.topViewController()!.present(activityVC, animated: true, completion: nil)

    }
}
