//
//  MemberTableViewCell.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/04/17.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    @IBOutlet weak var circleThumbnail: UIImageView!
    @IBOutlet weak var screenNane: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setItems(member: Member) {
        name.text = member.name
        screenNane.text = member.screenName
        circleThumbnail.kf.setImage(with: member.icon)
    }
}
