//
//  PATCH_posts_Request.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/05.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

extension ESAApiClient {
    struct PatchPostsRequest: ESARequestType {
        typealias Response = Post

        let postParameters: PostPostsParameters
        init(postParameters: PostPostsParameters) {
            self.postParameters = postParameters
        }

        var method: HTTPMethod {
            return .patch
        }

        var parameters: Any? {
            return postParameters.createParameters()
        }

        var path: String {
            return Constants.Esa.apiVersion + "/" + teamPath + "/posts/" + String(postParameters.number!)
        }
    }
}
