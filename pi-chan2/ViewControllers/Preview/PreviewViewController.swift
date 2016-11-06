//
//  PreviewViewController.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/04/12.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import SVProgressHUD
import FontAwesome_swift
import SafariServices
import Toaster
import SDCAlertView
import NSDate_TimeAgo

class PreviewViewController: UIViewController, UIWebViewDelegate {
    var postNumber: Int!
    let localHtml = R.file.mdHtml()!.path
    var post: Post?

    @IBOutlet weak var deleteButton: UIBarButtonItem!
//    @IBOutlet weak var starButton: UIBarButtonItem!
//    @IBOutlet weak var eyeButton: UIBarButtonItem!
    @IBOutlet weak var commentButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()

        let req = URLRequest(url: URL(string: localHtml)!)
        webView.delegate = self;
        webView.loadRequest(req)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadByNotification), name: ESAObserver.edit, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadByNotification), name: ESAObserver.login, object: nil)
    }

    func initNavigation() {
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        deleteButton.setTitleTextAttributes(attributes, for: .normal)
        deleteButton.title = String.fontAwesomeIcon(name: .trashO)
        commentButton.setTitleTextAttributes(attributes, for: .normal)
        commentButton.title = String.fontAwesomeIcon(name: .comments)
        editButton.setTitleTextAttributes(attributes, for: .normal)
        editButton.title = String.fontAwesomeIcon(name: .edit)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: ESAObserver.edit, object: nil)
        NotificationCenter.default.removeObserver(self, name: ESAObserver.login, object: nil)
    }

    func reloadByNotification(notification: Notification) {
        loadGetPostApi()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadGetPostApi()
    }

    func loadGetPostApi() {
        SVProgressHUD.showLoading()
        let request = ESAApiClient.GetPostRequest(number: postNumber!)
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                self.post = response
                self.setMarkdown()
                self.navigationItem.title = response.wip ? "[WIP]\(response.name)" : response.name
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }

    func setMarkdown() {
        let category = post?.category != nil ? "###### \(post!.category!)/ \\n" : ""
        let mdPrefixTitle = category + "# \(post!.name)\\n\\n"
        var md = mdPrefixTitle + post!.bodyMd.replacedNewLine()
        md += createCommentView()
        let js = "insert('\(md.replacingOccurrences(of: "'", with: "\\'"))');"
        log?.debug("\(js)")
        self.webView.stringByEvaluatingJavaScript(from: js)
    }

    func createCommentView() -> String {
        guard let comments = post?.comments, comments.count > 0 else {
            return ""
        }
        var md = "\\n\\n---\\n <div class='pi-chan'> <h2>:speech_balloon: Comments (\(comments.count))</h2>"
        for comment in comments {
            md += "<div class='comment'><h4 class='name'><img class='icon' src=\(comment.createdBy.icon) />"
            md += "<span class='screen_name'>`\(comment.createdBy.screenName)`</span></h4>"
            md += "<div class='md'>\(comment.bodyMd.replacedNewLine())</div><div  class='date'>"
            md += NSDate(timeIntervalSince1970: comment.updatedAt.timeIntervalSince1970).timeAgo() + "</div></div>"
        }
        return md + "</div>"
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        log?.info("\(request.url)")

        guard let url = request.url else {
            return false
        }
        if url.absoluteString.hasPrefix("file:///posts") {
            goPreviewToPreview(url: request.url!)
            return false
        }
        if navigationType == .other {
            return true
        } else {
            let safari = SFSafariViewController(url: request.url!, entersReaderIfAvailable: true)
            present(safari, animated: true, completion: nil)
            return false
        }
    }

    func goPreviewToPreview(url: URL) {
        let nextPostNumber = Int(url.absoluteString.replacingOccurrences(of: "file:///posts/", with: ""))!
        performSegue(withIdentifier: R.segue.previewViewController.previewToPreview.identifier, sender: nextPostNumber)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.previewViewController.previewToPreview.identifier {
            let previewViewController = segue.destination as! PreviewViewController
            previewViewController.postNumber = sender as! Int
        }
        if segue.identifier == R.segue.previewViewController.toEditor.identifier {
            let destinationNavigationController = segue.destination as! UINavigationController
            let editor = destinationNavigationController.topViewController as! EditorViewController
            editor.post = post
        }
    }

    @IBAction func openEditor(sender: AnyObject) {
        performSegue(withIdentifier: R.segue.previewViewController.toEditor.identifier, sender: nil)
    }

    @IBAction func onDeleteTapped(_ sender: Any) {
        guard let post = post else {
            return
        }
        let alert = AlertController(title: "記事削除", message: "\(post.fullName) を本当に削除しますか？", preferredStyle: .actionSheet)
        alert.add(AlertAction(title: "キャンセル", style: .preferred))
        alert.add(AlertAction(title: "Delete", style: .destructive) {
            _ in self.showDeleteDialog()
        })
        alert.present()
    }

    func showDeleteDialog() {
        let alert = AlertController(title: "記事を削除", message: "この操作は取り消せません。\nよろしいですか？", preferredStyle: .alert)
        alert.add(AlertAction(title: "キャンセル", style: .preferred))
        alert.add(AlertAction(title: "削除", style: .destructive) {
            _ in self.loadDeletePostsApi()
        })
        alert.present()
    }

    func loadDeletePostsApi() {
        SVProgressHUD.showLoading()
        let request = ESAApiClient.DeletePostsRequest(number: postNumber)
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(_):
                let _ = self.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: ESAObserver.delete, object: nil)
                Toast.showLong(text: "記事を削除しました (\\( ⁰⊖⁰)/)")
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }

    @IBAction func onCommentTapped(_ sender: Any) {
        showTextViewDialog(text: nil)
    }

    func showTextViewDialog(text: String?) {
        let alert = AlertController(title: "コメントを入力", message: "# Input comment (with Markdown)")
        let bounds = CGRect(x: 0, y: 0, width: 238, height: 100)
        let textView = UITextView(frame: bounds)
        textView.borderWidth = 1
        textView.borderColor = UIColor.grayUITextFieldBorderColor
        textView.cornerRadius = 6
        textView.font = R.font.latoRegular(size: 16)
        textView.textColor = UIColor.esaFontBlue
        textView.becomeFirstResponder()
        alert.contentView.addSubview(textView)
        alert.add(AlertAction(title: "キャンセル", style: .normal))
        alert.add(AlertAction(title: "投稿", style: .preferred) {
            _ in self.loadPostCommentApi(bodyMd: textView.text)
        })
        textView.centerXAnchor.constraint(equalTo: alert.contentView.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: alert.contentView.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: alert.contentView.bottomAnchor).isActive = true
        alert.present()
    }

    func showCommentConfirmDialog(bodyMd: String) {
        let alert = AlertController(title: "コメントを投稿", message: "\(bodyMd)\n\n 上記コメントを投稿します、良いですか？", preferredStyle: .alert)
        alert.add(AlertAction(title: "キャンセル", style: .normal))
        alert.add(AlertAction(title: "投稿", style: .preferred) {
            _ in self.loadPostCommentApi(bodyMd: bodyMd)
        })
        alert.present()
    }

    func loadPostCommentApi(bodyMd: String) {
        SVProgressHUD.showLoading()
        let request = ESAApiClient.PostPostsCommentsRequest(number: postNumber, bodyMd: bodyMd)
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(_):
                self.loadGetPostApi()
                Toast.showLong(text: "コメントを投稿しました (\\( ⁰⊖⁰)/)")
                let js = "window.scrollTo(0.0, 10000.0)"
                self.webView.stringByEvaluatingJavaScript(from: js)
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }
}
