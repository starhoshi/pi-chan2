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

class PreviewViewController: UIViewController, UIWebViewDelegate {
    var postNumber: Int!
    let localHtml = R.file.mdHtml()!.path
    var post: Post?

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        rightBarButton.setTitleTextAttributes(attributes, for: .normal)
        rightBarButton.title = String.fontAwesomeIcon(name: .edit)

        let req = URLRequest(url: URL(string: localHtml)!)
        webView.delegate = self;
        webView.loadRequest(req)
    }

    override func viewDidAppear(_ animated: Bool) {
//        if Global.fromLogin || Global.posted {
//        loadGetPostApi()
//            Global.fromLogin = false
//            Global.posted = false
//        }
    }

    func loadGetPostApi() {
        SVProgressHUD.showLoading()
        let request = ESAApiClient.GetPostRequest(number: postNumber!)
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                self.post = response
                self.navigationItem.title = response.name
                let md = response.getModyMdReplacedNewLine()
                let js = "insert('\(md.replacingOccurrences(of: "'", with: "\\'"))');"
                log?.debug("\(js)")
                self.webView.stringByEvaluatingJavaScript(from: js)
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadGetPostApi()
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
        let previewViewController = segue.destination as! PreviewViewController
        previewViewController.postNumber = sender as! Int
    }

    @IBAction func openEditor(sender: AnyObject) {
//        Window.openEditor(self, post: post)
    }
}
