//
//  AppDelegate.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import OAuthSwift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Fabric.with([Crashlytics.self])
        IQKeyboardManager.sharedManager().enable = true
        settingTabNavBar()

        return true
    }

    private func settingTabNavBar() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.esaGreen
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: R.font.latoRegular(size: 19)!, NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()

        // tabbar settings
        let titleFontAll: UIFont = R.font.latoRegular(size: 11)!
        let attributesNormal = [NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: titleFontAll]
        let attributesSelected = [NSForegroundColorAttributeName: UIColor.esaGreen, NSFontAttributeName: titleFontAll]
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        if (url.host == "oauth-callback") {
            OAuthSwift.handle(url: url)
        }
        return true
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handled = handleShortCutItem(shortcutItem: shortcutItem)
        completionHandler(handled)
    }

    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        let editor = R.storyboard.editor().instantiateInitialViewController()!
        UIApplication.topViewController()?.present(editor, animated: true, completion: nil)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
//        SirenUpdater.checkVersion(checkType: .immediately)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
//        SirenUpdater.checkVersion(checkType: .immediately)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
//        SirenUpdater.checkVersion(checkType: .immediately)
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
