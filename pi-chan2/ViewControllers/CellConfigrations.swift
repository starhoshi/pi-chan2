//
//  CellConfigrations.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/04/17.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import FontAwesome_swift
import VTAcknowledgementsViewController

struct Section {
    let title: String
    let cellContents: [CellContent]
}

struct CellContent {
    let title: String
    let icon: UIImage
    let cellType: UITableViewCellAccessoryType
    let tapped: () -> Void
}

// sectionList

let sectionList = [
    esaInfoSection,
    applicationSection,
    developerSection
]

// esa.io

let esaInfoSection = Section(
    title: "esa.io",
    cellContents: [
        esaHomePageContent,
        esaTermsContent
    ]
)

let esaHomePageContent = CellContent(
    title: "esa.io",
    icon: UIImage.fontAwesomeIcon(name: .safari, textColor: UIColor.esaGreen, size: CGSize(width: 30, height: 30)),
    cellType: .disclosureIndicator,
    tapped: { _ in
        Share.openBrowser(Constants.Esa.Url.index)
    }
)

let esaTermsContent = CellContent(
    title: "Terms",
    icon: UIImage.fontAwesomeIcon(name: .exclamation, textColor: UIColor.esaGreen, size: CGSize(width: 30, height: 30)),
    cellType: .disclosureIndicator,
    tapped: { _ in
        Share.openBrowser(Constants.Esa.Url.terms)
    }
)

// esa.io

let applicationSection = Section(
    title: "ピーちゃん",
    cellContents: [
        repositoryContent,
        reviewContent,
        shareContent,
        licenseContent,
        versionContent
    ]
)

let repositoryContent = CellContent(
    title: "Github Repository",
    icon: UIImage.fontAwesomeIcon(name: .github, textColor: UIColor.esaGreen, size: CGSize(width: 30, height: 30)),
    cellType: .disclosureIndicator,
    tapped: { _ in
        Share.openAppStore(Constants.Pichan.Url.gitHub)
    }
)

let reviewContent = CellContent(
    title: "Review",
    icon: UIImage.fontAwesomeIcon(name: .star, textColor: UIColor.esaGreen, size: CGSize(width: 30, height: 30)),
    cellType: .disclosureIndicator,
    tapped: { _ in
        Share.openBrowser(Constants.Pichan.Url.iTunes.getItmsReview())
    }
)

let shareContent = CellContent(
    title: "Share",
    icon: UIImage.fontAwesomeIcon(name: .shareAlt, textColor: UIColor.esaGreen, size: CGSize(width: 30, height: 30)),
    cellType: .disclosureIndicator,
    tapped: { _ in
        Share.showAppShareActivityView()
    }
)

let licenseContent = CellContent(
    title: "Libraries",
    icon: UIImage.fontAwesomeIcon(name: .creativeCommons, textColor: UIColor.esaGreen, size: CGSize(width: 30, height: 30)),
    cellType: .disclosureIndicator,
    tapped: { _ in
        let vt = VTAcknowledgementsViewController.init(path: R.file.acknowledgementsPlist()?.path)!
        UIApplication.topViewController()?.navigationController?.pushViewController(vt, animated: true)
    }
)

let versionContent = CellContent(
    title: "ver \(Bundle.appVersion() ?? "")",
    icon: UIImage.fontAwesomeIcon(name: .tag, textColor: UIColor.esaGreen, size: CGSize(width: 30, height: 30)),
    cellType: .none,
    tapped: { _ in }
)

// developer

let developerSection = Section(
    title: "Developer",
    cellContents: [
        twitterContent,
        githubContent
    ]
)

let twitterContent = CellContent(
    title: "Twitter: @star__hoshi",
    icon: UIImage.fontAwesomeIcon(name: .twitter, textColor: UIColor.esaGreen, size: CGSize(width: 30, height: 30)),
    cellType: .disclosureIndicator,
    tapped: { _ in
        Share.openBrowser(Constants.Starhoshi.Url.twitter)
    }
)

let githubContent = CellContent(
    title: "Github: starhoshi",
    icon: UIImage.fontAwesomeIcon(name: .githubAlt, textColor: UIColor.esaGreen, size: CGSize(width: 30, height: 30)),
    cellType: .disclosureIndicator,
    tapped: { _ in
        Share.openBrowser(Constants.Starhoshi.Url.gitHub)
    }
)
