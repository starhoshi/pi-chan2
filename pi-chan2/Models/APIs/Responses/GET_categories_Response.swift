//
//  GET_categories_Response.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/06.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import ObjectMapper

class GetCategoriesResponse: PaginationMappable {

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
    }
}
