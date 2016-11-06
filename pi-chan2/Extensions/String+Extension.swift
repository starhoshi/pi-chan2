//
//  String+Extension.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/06.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
extension String {
    func replacedNewLine() -> String {
        var md = self.replacingOccurrences(of: "\r\n", with: "#!#!#")
        md = md.replacingOccurrences(of: "\n\r", with: "#!#!#")
        md = md.replacingOccurrences(of: "\n", with: "#!#!#")
        md = md.replacingOccurrences(of: "\r", with: "#!#!#")
        md = md.replacingOccurrences(of: "#!#!#", with: "\\n")
        return md
    }
}
