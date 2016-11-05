//
//  EditorViewController.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/04/14.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import FontAwesome_swift
//import UITextView_Placeholder
import SVProgressHUD
import SCLAlertView
import SDCAlertView
import Toaster

class EditorViewController: UIViewController {
    var post: Post?
    // var postsParameters: PostsParameters!

    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentViewWidthConstraint.constant = view.frame.width
        contentViewHeightConstraint.constant = CGFloat(view.frame.height - 64)
        // sendButton.setFAIcon(.FASend, iconSize: 22, forState: .Normal)
        // cancelButton.setFAIcon(.FAClose, iconSize: 22, forState: .Normal)
        setStatusBarBackground()
        setTextViewStyle()
        textView.text = post?.bodyMd
        textField.text = post?.fullName
        navigationItem.title = post?.name ?? "New Posts"
//        client = Esa(token: KeychainManager.getToken()!, currentTeam: KeychainManager.getTeamName()!)
    }

    override func viewDidAppear(_ animated: Bool) {
//        Global.fromLogin = false
    }

    func setTextViewStyle() {
//        textView.placeholder = "# Input with Markdown"
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.grayUITextFieldBorderColor.cgColor
        textView.layer.cornerRadius = 6
    }

    func setStatusBarBackground() {
//        let statusBarBackground = UIView(frame: CGRect(0, 0, self.view.frame.width, CGRectGetHeight(UIApplication.shared.statusBarFrame)))
//        statusBarBackground.backgroundColor = UIColor.esaGreen
//        self.view.addSubview(statusBarBackground)
    }

    @IBAction func post(sender: AnyObject) {
        if (textField.text != nil && textField.text != "" && textField.text != "/") {
            showAlert()
        } else {
            Toast.showLong(text: "タイトルは必ず入力してください (\\( ⁰⊖⁰)/)")
        }
    }

    func showAlert() {
        let alertTitle = post == nil ? "Create post." : "Update post."
        let alert = SCLAlertView()
        let commitMessage = alert.addTextField("Enter your name")
        commitMessage.text = alertTitle
        alert.addButton("Save as WIP") {
//            self.callPostApi(true, commitMessage: commitMessage.text)
        }
        alert.addButton("Ship It!") {
//            self.callPostApi(false, commitMessage: commitMessage.text)
        }
        alert.showEdit(
            alertTitle,
            subTitle: "Write explaining this change.(Optional)",
            closeButtonTitle: "Cancel",
            colorStyle: 0x0a9b94
        )
    }

//    func callPostApi(wip: Bool, commitMessage: String?) {
//        self.postsParameters = self.createPostsParameters(wip, commitMessage: commitMessage)
//        SVProgressHUD.showWithStatus("Loading...")
//        if let _ = post {
//            patch()
//        } else {
//            newPost()
//        }
//    }

//    func newPost() {
//        client.newPost(postsParameters) { result in
//            SVProgressHUD.dismiss()
//            switch result {
//            case .Success(let posts):
//                log?.info("\(posts)")
//                JLToast.showPichanToast("投稿が完了しました! (\\( ⁰⊖⁰)/)")
//                self.dismissViewControllerAnimated(true, completion: nil)
//                Global.posted = true
//            case .Failure(let error):
//                ErrorHandler.errorAlert(error, controller: self)
//            }
//        }
//    }

//    func patch() {
//        client.patchPost(postsParameters) { result in
//            SVProgressHUD.dismiss()
//            switch result {
//            case .Success(let posts):
//                log?.info("\(posts)")
//                JLToast.showPichanToast("編集が投稿されました! (\\( ⁰⊖⁰)/)")
//                self.dismissViewControllerAnimated(true, completion: nil)
//                Global.posted = true
//            case .Failure(let error):
//                ErrorHandler.errorAlert(error, controller: self)
//            }
//        }
//    }

//    func createPostsParameters(wip: Bool, commitMessage: String?) -> PostsParameters {
//        let category = Esa.parseCategory(textField.text!)
//        return PostsParameters(
//            number: post?.number,
//            name: category.name,
//            bodyMd: textView.text,
//            tags: post?.tags,
//            category: category.category,
//            wip: wip,
//            message: commitMessage,
//            originalRevision: nil
//        )
//    }

    @IBAction func close(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
