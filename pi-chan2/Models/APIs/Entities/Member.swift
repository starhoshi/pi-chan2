//
//  Member.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import ObjectMapper

class Member: Mappable {
    var name: String = ""
    var screenName: String = ""
    var icon: URL = URL.defaultUrl()
//    var email: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        name <- map["name"]
        screenName <- map["screen_name"]
        icon <- (map["icon"], URLTransform())
    }
}

