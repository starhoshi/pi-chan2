//
//  POST_posts_comments.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/06.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

extension ESAApiClient {
    struct PostPostsCommentsRequest: ESARequestType {
        typealias Response = PostPostsCommentsResponse

        let number: Int
        let bodyMd: String

        init(number: Int, bodyMd: String) {
            self.number = number
            self.bodyMd = bodyMd
        }

        var method: HTTPMethod {
            return .post
        }

        var parameters: Any? {
            return ["comment": ["body_md": bodyMd]]
        }

        var path: String {
            return Constants.Esa.apiVersion + "/\(teamPath)/posts/\(number)/comments"
        }
    }
}
