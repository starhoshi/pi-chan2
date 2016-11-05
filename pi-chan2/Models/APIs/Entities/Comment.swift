//
//  Comment.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/05.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import ObjectMapper

class Comment: Mappable {
    var id: String = ""
    var bodyMd: String = ""
    var bodyHtml: String = ""
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var url: URL = URL.defaultUrl()
    var createdBy: CreatedBy!
    var stargazersCount: Int = 0
    var star: Bool = false

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["id"]
        bodyMd <- map["body_md"]
        bodyHtml <- map["body_html"]
        createdAt <- (map["created_at"], ISO8601DateTransform())
        updatedAt <- (map["updated_at"], ISO8601DateTransform())
        url <- map["url"]
        createdBy <- map["created_by"]
        stargazersCount <- map["stargazers_count"]
        star <- map["star"]
    }
}

