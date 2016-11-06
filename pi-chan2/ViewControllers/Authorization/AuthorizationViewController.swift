//
//  LoginViewController.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/03/28.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import APIKit
import SVProgressHUD
import FontAwesome_swift
import XLActionController
import KeychainAccess
import Toaster

class AuthorizationViewController: UIViewController {
    var teams: [Team] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func login(sender: AnyObject) {
        ESAAuthorization.oauth2(
            success: { credential in
                log?.info(credential.oauthToken)
                Keychain()[Keychain.tokenKey] = credential.oauthToken
                self.loadTeamsApi()
            }, failure: { error in
                log?.info(error.localizedDescription)
            }
        )
    }

    func loadTeamsApi() {
        SVProgressHUD.showLoading()
        let request = ESAApiClient.GetTeamsRequest()
        ESASession.send(request) {
            result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                self.teams = response.teams
                self.selectTeamWhenJoinedMultiTeams()
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }

    func selectTeamWhenJoinedMultiTeams() {
        switch teams.count {
        case 1:
            successAuthorization(teamName: teams.first!.name)
            break
        default:
            showTeamSelectActionSheet()
            break
        }
    }

    func showTeamSelectActionSheet() {
        let actionSheet = TwitterActionController()
        actionSheet.headerData = "Select Your Team (\\( ⁰⊖⁰)/)"
        teams.forEach { team in
            let image = UIImage(data: try! Data(contentsOf: team.icon))!
            actionSheet.addAction(Action(
                ActionData(title: team.name,
                    subtitle: team.url.absoluteString,
                    image: image
                ),
                style: .default,
                handler: { action in
                    self.successAuthorization(teamName: team.name)
                    log?.debug(team.name)
                })
            )
        }
        present(actionSheet, animated: true, completion: nil)
    }

    func successAuthorization(teamName: String) {
        Keychain()[Keychain.teamKey] = teamName
        self.dismiss(animated: true, completion: nil)
        Toast.showLong(text: "\(teamName) へのログインが成功しました!")
        NotificationCenter.default.post(name: ESAObserver.login, object: nil)
    }

    @IBAction func onGitHubTapped(_ sender: Any) {
        Share.openAppStore(Constants.Pichan.Url.gitHub)
    }
}
