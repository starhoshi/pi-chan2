//
//  PostTableViewCell.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/04/06.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import Kingfisher
import FontAwesome_swift
//import SwiftDate
//import NSDate_TimeAgo
import MGSwipeTableCell

class PostTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var circleThumbnail: UIImageView!
    @IBOutlet weak var circleUpdateThumbnail: UIImageView!
    @IBOutlet weak var wip: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var createdBy: UILabel!
    @IBOutlet weak var starIcon: UILabel!
    @IBOutlet weak var starCount: UILabel!
    @IBOutlet weak var eyeIcon: UILabel!
    @IBOutlet weak var eyeCount: UILabel!
    @IBOutlet weak var commentsIcon: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var checkIcon: UILabel!
    @IBOutlet weak var checkCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // starIcon.setFAIcon(.FAStar, iconSize: 14)
        // eyeIcon.setFAIcon(.FAEye, iconSize: 14)
        // commentsIcon.setFAIcon(.FAComments, iconSize: 14)
        // checkIcon.setFAIcon(.FACheckSquareO, iconSize: 14)
    }

//    func setItems(post: Post) {
//        category.text = post.category
//        title.text = post.name
//        starIcon.textColor = post.star ? UIColor.esaGreen() : UIColor.esaFontBlue()
//        eyeIcon.textColor = post.watch ? UIColor.esaGreen() : UIColor.esaFontBlue()
//        starCount.text = String(post.stargazersCount)
//        eyeCount.text = String(post.watchersCount)
//        commentsCount.text = String(post.commentsCount)
//        checkCount.text = "\(post.doneTasksCount)/\(post.tasksCount)"
//        wip.hidden = !post.wip
//        contentsView.alpha = post.wip ? 0.5 : 1.0
//        setCreatedBy(post)
//        setThumbnail(post)
//    }
//
//    func setThumbnail(post: Post) {
//        circleThumbnail.toCircle().kf_setImageWithURL(post.createdBy.icon)
//        circleUpdateThumbnail.hidden = post.createdBy.screenName == post.updatedBy.screenName ? true : false
//        circleUpdateThumbnail.toCircle().kf_setImageWithURL(post.updatedBy.icon)
//    }
//
//    func setCreatedBy(post: Post) {
//        var createdByText = ""
//        if post.updatedAt == post.createdAt {
//            createdByText += "Created by \(post.createdBy.screenName) | "
//            createdByText += post.createdAt.toDateFromISO8601()!.timeAgo()
//        } else {
//            createdByText += "Updated by \(post.updatedBy.screenName) | "
//            createdByText += post.updatedAt.toDateFromISO8601()!.timeAgo()
//        }
//        createdBy.text = createdByText
//    }
}
