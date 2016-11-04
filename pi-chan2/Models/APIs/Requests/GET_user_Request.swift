//
//  GET_user_Request.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

extension ESAApiClient {
    struct GetUserRequest: ESARequestType {
        typealias Response = User

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return "/user"
        }
    }
}
