//
//  GET_teams_Request.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

extension ESAApiClient {
    struct GetTeamsRequest: ESARequestType {
        typealias Response = GetTeamsResponse

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
            return Constants.Esa.apiVersion + "/" + "/teams"
        }
    }
}
