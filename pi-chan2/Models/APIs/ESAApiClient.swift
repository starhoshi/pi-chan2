//
//  ESAApiClient.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit

final class ESAApiClient {
    private init() {

    }

    static func errorHandler(error: SessionTaskError) {
        log?.error("\(error)")

        switch error {
        case .connectionError(_):
            break
        case .requestError(_):
            break
        case .responseError(let e):
            break
        }
    }
}
