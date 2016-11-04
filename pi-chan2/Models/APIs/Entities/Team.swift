//
//  Team.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import ObjectMapper

class Team: Mappable {
    var description: String?
    var icon: URL = URL.defaultUrl()
    var name: String = ""
    // var privacy: Privacy
    var url: URL = URL.defaultUrl()

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        description <- map["description"]
        icon <- (map["icon"], URLTransform())
        name <- map["name"]
        url <- (map["url"], URLTransform())
    }
}
