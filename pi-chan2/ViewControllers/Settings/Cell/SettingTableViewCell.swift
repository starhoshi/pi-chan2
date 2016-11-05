//
//  SettingTableViewCell.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/04/17.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    var settingViewController: SettingsViewController?
    var cellContent: CellContent!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // FIXME: if else の書き方修正
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            cellContent.tapped()
        }
    }

    func setItems(cellContent: CellContent) {
        self.cellContent = cellContent
        titleLabel.text = cellContent.title
        icon.image = cellContent.icon
        self.accessoryType = cellContent.cellType
        self.selectionStyle = cellContent.cellType == .none ? .none : .default
    }
}
