//
//  GET_post_Request.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/05.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

extension ESAApiClient {
    struct GetPostRequest: ESARequestType {
        typealias Response = Post

        let number: Int

        init(number: Int) {
            self.number = number
        }

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return Constants.Esa.apiVersion + "/" + teamPath + "/posts/" + String(number)
        }
    }
}
