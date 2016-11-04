//
//  ViewController.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadGetStartPocketbookRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadGetStartPocketbookRequest() {
        SVProgressHUD.show()
        let request = ESAApiClient.GetUserRequest()
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                log?.info("schoolEnd:\(response)")
            case .failure(let error):
                ESAApiClient.errorHandler(error: error)
            }
        }
    }

}

