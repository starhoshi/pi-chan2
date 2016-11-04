//
//  Pagination.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import ObjectMapper

class PaginationMappable: Mappable {
    var prevPage: Int?
    var nextPage: Int?
    var totalCount: Int = 0

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        prevPage <- map["prev_page"]
        nextPage <- map["next_page"]
        totalCount <- map["total_count"]
    }
}
