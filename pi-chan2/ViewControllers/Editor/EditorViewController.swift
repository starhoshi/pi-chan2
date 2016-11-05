//
//  EditorViewController.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/04/14.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import FontAwesome_swift
import SVProgressHUD
import SCLAlertView
import SDCAlertView
import Toaster

class EditorViewController: UIViewController {
    var post: Post?
    var postsParameters: PostPostsParameters!

    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        cancelButton.setTitleTextAttributes(attributes, for: .normal)
        cancelButton.title = String.fontAwesomeIcon(name: .close)
        sendButton.setTitleTextAttributes(attributes, for: .normal)
        sendButton.title = String.fontAwesomeIcon(name: .send)

        setTextViewStyle()
        textView.text = post?.bodyMd
        textField.text = post?.fullName
        navigationItem.title = post?.name ?? "New Posts"
    }

    override func viewDidAppear(_ animated: Bool) {
//        Global.fromLogin = false
    }

    func setTextViewStyle() {
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.grayUITextFieldBorderColor.cgColor
        textView.layer.cornerRadius = 6
    }

    @IBAction func post(sender: AnyObject) {
        guard let text = textField.text, text != "", text != "/" else {
            Toast.showLong(text: "タイトルは必ず入力してください (\\( ⁰⊖⁰)/)")
            return
        }
        guard !text.hasSuffix("/") else {
            Toast.showLong(text: "/ の後に記事のタイトルを入力してください (\\( ⁰⊖⁰)/)")
            return
        }

        showAlert()
        textField.endEditing(true)
        textView.endEditing(true)
    }

    func showAlert() {
        let alertTitle = post == nil ? "Create post." : "Update post."
        let alert = SCLAlertView()
        let commitMessage = alert.addTextField("Enter your name")
        commitMessage.text = alertTitle
        alert.addButton("Save as WIP") {
            self.callPostApi(wip: true, commitMessage: commitMessage.text)
        }
        alert.addButton("Ship It!") {
            self.callPostApi(wip: false, commitMessage: commitMessage.text)
        }
        alert.showEdit(
            alertTitle,
            subTitle: "Write explaining this change.(Optional)",
            closeButtonTitle: "Cancel",
            colorStyle: 0x0a9b94
        )
    }

    func callPostApi(wip: Bool, commitMessage: String?) {
        self.postsParameters = createPostsParameters(wip: wip, commitMessage: commitMessage)
        if let _ = post {
            loadPatchPostsApi()
        } else {
            loadPostPostsApi()
        }
    }

    func loadPostPostsApi() {
        SVProgressHUD.showLoading()
        let request = ESAApiClient.PostPostsRequest(postParameters: postsParameters)
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(_):
                Toast.showLong(text: "投稿が完了しました! (\\( ⁰⊖⁰)/)")
                self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: ESAObserver.write, object: nil)
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }

    func loadPatchPostsApi() {
        SVProgressHUD.showLoading()
        let request = ESAApiClient.PatchPostsRequest(postParameters: postsParameters)
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(_):
                Toast.showLong(text: "編集が投稿されました! (\\( ⁰⊖⁰)/)")
                self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: ESAObserver.edit, object: nil)
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }

    func createPostsParameters(wip: Bool, commitMessage: String?) -> PostPostsParameters {
        let category = parseCategory(fullName: textField.text!)
        return PostPostsParameters(
            number: post?.number,
            name: category.name,
            bodyMd: textView.text,
            tags: post?.tags,
            category: category.category,
            wip: wip,
            message: commitMessage
        )
    }

    func parseCategory(fullName: String) -> (category: String, name: String) {
        var categoryArray = fullName.components(separatedBy: "/")
        let name = categoryArray.last
        categoryArray.removeLast()
        let category = categoryArray.joined(separator: "/")
        return (category: category, name: name!)
    }

    @IBAction func close(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
