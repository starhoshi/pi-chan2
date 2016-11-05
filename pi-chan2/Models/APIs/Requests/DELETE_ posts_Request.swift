//
//  DELETE_ posts_Request.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/06.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

extension ESAApiClient {
    struct DeletePostsRequest: ESARequestType {
        typealias Response = DeletePostsResponse

        let number: Int

        init(number: Int) {
            self.number = number
        }

        var method: HTTPMethod {
            return .delete
        }

        var path: String {
            return Constants.Esa.apiVersion + "/" + teamPath + "/posts/" + String(number)
        }
    }
}
