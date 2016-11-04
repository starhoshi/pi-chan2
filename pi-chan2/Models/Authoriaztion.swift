//
//  Authoriaztion.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import OAuthSwift

class Authorization {
    static func oauth2(controller: UIViewController, success: (_ credential: OAuthSwiftCredential) -> Void, failure: (_ error: NSError) -> Void) {

        let env = ProcessInfo.processInfo.environment

        let oauthswift = OAuth2Swift(
            consumerKey: "Esa Client ID",
            consumerSecret: "Esa Client Secret",
            authorizeUrl: "https://api.esa.io/oauth/authorize",
            accessTokenUrl: "https://api.esa.io/oauth/token",
            responseType: "code"
        )
        oauthswift.authorize_url_handler = SafariURLHandler(viewController: controller)
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "pi-chan://oauth-callback")!,
            scope: "read+write",
            state: "a7e567e2fb858f0e12838798016ee9cf8ccc778",
            success: { credential, response, parameters in
                success(credential: credential)
            },
            failure: { error in
                failure(error: error)
            }
        )
    }
}
