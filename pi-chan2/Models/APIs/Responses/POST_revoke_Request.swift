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

        var contentType: String? {
            return "application/x-www-form-urlencoded"
        }

        var parameters: Any? {
            let aa = FormURLEncodedBodyParameters(formObject: ["token": Keychain()[Keychain.tokenKey] ?? ""])
            return aa
        }

        var path: String {
            return "oauth/revoke"
        }
    }
}
