//
//  User.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var id: String = ""
    var name: String = ""
    var screenName: String = ""
    var createdAt: String = ""
    var updatedAt: String = ""
    var icon: URL = URL.defaultUrl()
    var email: String = ""

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        screenName <- map["screen_name"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        icon <- (map["icon"], URLTransform())
        email <- map["email"]
    }
}
