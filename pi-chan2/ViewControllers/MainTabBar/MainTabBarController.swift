//
//  MainTabBarController.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/03/27.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import FontAwesome_swift

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.items?[0].image = UIImage.fontAwesomeIcon(name: .fileTextO, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        tabBar.items?[1].image = UIImage.fontAwesomeIcon(name: .smileO, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
        tabBar.items?[2].image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
