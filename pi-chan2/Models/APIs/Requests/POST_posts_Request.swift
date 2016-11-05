//
//  POST_posts_Request.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/05.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

extension ESAApiClient {
    struct PostPostsRequest: ESARequestType {
        typealias Response = Post

        let postParameters: PostPostsParameters
        init(postParameters: PostPostsParameters) {
            self.postParameters = postParameters
        }

        var method: HTTPMethod {
            return .post
        }

        var parameters: Any? {
            return postParameters.createParameters()
        }

        var path: String {
            return teamPath + "/posts"
        }
    }
}

struct PostPostsParameters {
    let number: Int?
    let name: String
    let bodyMd: String?
    let tags: [String]?
    let category: String?
    let wip: Bool
    let message: String?

    func createParameters() -> [String: Any] {
        var post: [String: Any] = [
            "name": name,
            "wip": wip
        ]
        if let bodyMd = bodyMd {
            post["body_md"] = bodyMd
        }
        if let tags = tags {
            post["tags"] = tags
        }
        if let category = category {
            post["category"] = category
        }
        if let message = message {
            post["message"] = message
        }
        return ["post": post]
    }
}
