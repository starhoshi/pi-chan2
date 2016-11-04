//
//  Constants.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation

struct Constants {
    struct Esa {
        struct Url {
            static let index = NSURL(string: "https://esa.io")!
            static let terms = NSURL(string: "https://docs.esa.io/posts/5")!
            static let api = URL(string: "https://api.esa.io/v1")!
        }
    }

    struct Pichan {
        static let scheme = "pi-chan://"
        static let iTunes = ITunes(storeId: "1107328970")
        static let gitHub = NSURL(string: "https://github.com/starhoshi/pi-chan2")!
    }

    struct Opanimed {
        static let iTunes = ITunes(storeId: "1148280792")
    }

    struct Starhoshi {
        struct Url {
            static let gitHub = NSURL(string: "https://github.com/starhoshi")!
            static let twitter = NSURL(string: "https://twitter.com/star__hoshi")!
        }
    }
}

struct ITunes {
    let storeId: String

    func getITunes() -> URL {
        return URL(string: "https://itunes.apple.com/jp/app/id\(storeId)")!
    }
    func getItms() -> URL {
        return URL(string: "itms-apps://itunes.apple.com/app/\(storeId)")!
    }
    func getItmsReview() -> URL {
        return URL(string: "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(storeId)")!
    }
}
