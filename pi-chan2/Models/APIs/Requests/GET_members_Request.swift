//
//  GET_members_Request.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

extension ESAApiClient {
    struct GetMembersRequest: ESARequestType {
        typealias Response = GetMembersResponse

        let page: Int
        let perPage: Int

        init(page: Int = 1, perPage: Int = 50) {
            self.page = page
            self.perPage = perPage
        }

        var method: HTTPMethod {
            return .get
        }

        var queryParameters: [String: Any]? {
            return ["page": page, "per_page": perPage]
        }

        var path: String {
            return Constants.Esa.apiVersion + "/" + teamPath + "/members"
        }
    }
}
