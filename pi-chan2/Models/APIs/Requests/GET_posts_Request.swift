//
//  GET_posts_Request.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

extension ESAApiClient {
    struct GetPostsRequest: ESARequestType {
        typealias Response = GetPostsResponse

        let page: Int
        let perPage: Int
        let q: String?

        init(page: Int = 1, perPage: Int = 50, q: String? = nil) {
            self.page = page
            self.perPage = perPage
            self.q = q
        }

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return "/teams/currentTeam/posts"
        }
    }
}
