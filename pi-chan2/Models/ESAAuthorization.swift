//
//  Authoriaztion.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import OAuthSwift
import UIKit

class ESAAuthorization {
    static func oauth2(success: @escaping (_ credential: OAuthSwiftCredential) -> Void, failure: @escaping (_ error: Error) -> Void) {

        let env = ProcessInfo.processInfo.environment

        let oauthswift = OAuth2Swift(
            consumerKey: env["ESA_CLIENT_ID"]!,
            consumerSecret: env["ESA_CLIENT_SECRET"]!,
            authorizeUrl: Constants.Esa.Url.authorize.absoluteString,
            accessTokenUrl: Constants.Esa.Url.token.absoluteString,
            responseType: "code"
        )
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: UIApplication.topViewController()!, oauthSwift: oauthswift)
        oauthswift.authorize(
            withCallbackURL: URL(string: "pi-chan://oauth-callback")!,
            scope: "read+write", state: "a7e567e2fb858f0e12838798016ee9cf8ccc778",
            success: { credential, response, parameters in
                success(credential)
            },
            failure: { error in
                print(error.localizedDescription)
                failure(error)
            }
        )
    }
}
