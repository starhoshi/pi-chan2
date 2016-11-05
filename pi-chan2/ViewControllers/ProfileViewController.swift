//
//  ProfileViewController.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/04/24.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import FontAwesome_swift
import SVProgressHUD
import SDCAlertView
import Toaster
import KeychainAccess

class ProfileViewController: UIViewController {

    @IBOutlet weak var settingButton: UIBarButtonItem!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        settingButton.setTitleTextAttributes(attributes, for: .normal)
        settingButton.title = String.fontAwesomeIcon(name: .infoCircle)
        loadGetUserApi()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadByNotification), name: ESAObserver.login, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: ESAObserver.login, object: nil)
    }

    func reloadByNotification(notification: Notification) {
        loadGetUserApi()
    }

    func loadGetUserApi() {
        SVProgressHUD.showLoading()
        let request = ESAApiClient.GetUserRequest()
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                self.setUserData(user: response)
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }

    func setUserData(user: User) {
        userIcon.kf.setImage(with: user.icon)
        screenName.text = user.screenName
        name.text = user.name
        mail.text = user.email
    }

    @IBAction func clickRevoke(sender: AnyObject) {
        let alert = AlertController(title: "認証解除", message: "ピーちゃんと esa.io の認証を解除しますか？\n\n解除した後も再度認証いただければ、またピーちゃんをご利用いただけます。", preferredStyle: .alert)
        alert.add(AlertAction(title: "キャンセル", style: .normal))
        alert.add(AlertAction(title: "認証解除", style: .destructive) {
            _ in self.loadRevokeApi()
        })
        alert.present()
    }

    func loadRevokeApi() {
        SVProgressHUD.showLoading()
        let request = ESAApiClient.GetUserRequest()
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(_):
                try? Keychain().removeAll()
                Toast.showLong(text: "アプリ連携を解除しました (\\( ⁰⊖⁰)/)\n\n再度ご利用の場合は、もう一度認証をお願いします。")
                let login = R.storyboard.authorization().instantiateInitialViewController()!
                self.present(login, animated: true, completion: nil)
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }
}
