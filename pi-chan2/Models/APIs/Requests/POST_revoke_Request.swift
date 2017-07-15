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
import Keys

extension ESAApiClient {
    struct PostRevokeRequest: ESARequestType {
        typealias Response = PostRevokeResponse

        var method: HTTPMethod {
            return .post
        }

        var parameters: Any? {
            _ = ProcessInfo.processInfo.environment
            return [
                "token": Keychain()[Keychain.tokenKey] ?? "",
                "client_id": Pichan2Keys().esaClientId(),
                "client_secret": Pichan2Keys().esaClientSecret(),
            ]
        }

        var path: String {
            return "oauth/revoke"
        }
    }
}
