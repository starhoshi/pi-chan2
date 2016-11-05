//
//  ESAObserver.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/05.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation

final class ESAObserver {
    static let edit = NSNotification.Name(rawValue: "edit")
    static let write = NSNotification.Name(rawValue: "write")
    static let login = NSNotification.Name(rawValue: "login")
}
