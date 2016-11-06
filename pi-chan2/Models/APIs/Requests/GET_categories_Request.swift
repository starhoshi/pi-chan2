//
//  GET_categories_Request.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/06.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

extension ESAApiClient {
    struct GetCategoriesRequest: ESARequestType {
        typealias Response = GetCategoriesResponse

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return Constants.Esa.apiVersion + "/" + teamPath + "/categories"
        }
    }
}
