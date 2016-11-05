//
//  POST_revoke_Request.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit
import KeychainAccess

extension ESAApiClient {
    struct PostRevokeRequest: ESARequestType {
        typealias Response = PostRevokeResponse

        var method: HTTPMethod {
            return .post
        }

        var parameters: Any? {
            let env = ProcessInfo.processInfo.environment
            return [
                "token": Keychain()[Keychain.tokenKey] ?? "",
                "client_id": env["ESA_CLIENT_ID"]!,
                "client_secret": env["ESA_CLIENT_SECRET"]!,
            ]
        }

        var path: String {
            return "oauth/revoke"
        }
    }
}
