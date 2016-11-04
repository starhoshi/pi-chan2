//
//  GET_members_Response.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import ObjectMapper

class GetMembersResponse: PaginationMappable {
    var members: [Member] = []

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        members <- map["members"]
    }
}
