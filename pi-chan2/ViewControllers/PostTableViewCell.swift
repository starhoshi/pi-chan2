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
        starIcon.font = UIFont.fontAwesome(ofSize: 14)
        starIcon.text = String.fontAwesomeIcon(name: .star)
        eyeIcon.font = UIFont.fontAwesome(ofSize: 14)
        eyeIcon.text = String.fontAwesomeIcon(name: .eye)
        commentsIcon.font = UIFont.fontAwesome(ofSize: 14)
        commentsIcon.text = String.fontAwesomeIcon(name: .comments)
        checkIcon.font = UIFont.fontAwesome(ofSize: 14)
        checkIcon.text = String.fontAwesomeIcon(name: .checkSquareO)
    }

    func setItems(post: Post) {
        category.text = post.category
        title.text = post.name
        starIcon.textColor = post.star ? UIColor.esaGreen : UIColor.esaFontBlue
        eyeIcon.textColor = post.watch ? UIColor.esaGreen : UIColor.esaFontBlue
        starCount.text = String(post.stargazersCount)
        eyeCount.text = String(post.watchersCount)
        commentsCount.text = String(post.commentsCount)
        checkCount.text = "\(post.doneTasksCount)/\(post.tasksCount)"
        wip.isHidden = !post.wip
        contentsView.alpha = post.wip ? 0.5 : 1.0
//        setCreatedBy(post)
        setThumbnail(post)
    }

    func setThumbnail(_ post: Post) {
//        circleThumbnail.kf.setImage(with: post.createdBy.icon)
//        circleUpdateThumbnail.isHidden = post.createdBy.screenName == post.updatedBy.screenName ? true : false
//        circleUpdateThumbnail.kf.setImage(with: post.updatedBy.icon)
    }

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
