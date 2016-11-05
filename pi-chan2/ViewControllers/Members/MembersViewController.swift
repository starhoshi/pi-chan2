//
//  TeamsViewController.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/03/27.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import SVProgressHUD
import PullToRefreshSwift
import DZNEmptyDataSet

class MembersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var members: [Member] = []
    var nextPage: Int? = 1
    var loading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        resetAndLoadApi()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadByNotification), name: ESAObserver.login, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: ESAObserver.login, object: nil)
    }

    func reloadByNotification(notification: Notification) {
        resetAndLoadApi()
    }

    func initTableView() {
        tableView.register(R.nib.memberTableViewCell(), forCellReuseIdentifier: R.nib.memberTableViewCell.name)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.addPullRefresh { [weak self] in
            self?.resetAndLoadApi()
            self?.tableView.stopPullRefreshEver(false)
        }
    }

    func resetAndLoadApi() {
        members = []
        tableView.reloadData()
        loadMembersApi(page: 1)
    }

    func loadMembersApi(page: Int?) {
        guard let page = page, !SVProgressHUD.isVisible() else {
            log?.warning("not load...")
            return
        }
        SVProgressHUD.showLoading()
        let request = ESAApiClient.GetMembersRequest(page: page)
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                self.members += response.members
                self.nextPage = response.nextPage
                self.tableView.reloadData()
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }
}

extension MembersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MemberTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: R.nib.memberTableViewCell.name)! as! MemberTableViewCell
        cell.setItems(member: members[indexPath.row])
        if (members.count - 1) == indexPath.row {
            loadMembersApi(page: nextPage)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log?.debug("\(indexPath)")
        performSegue(withIdentifier: R.segue.membersViewController.toPosts, sender: "@" + members[indexPath.row].screenName)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let postsViewController: PostsViewController = segue.destination as! PostsViewController
        postsViewController.searchText = sender as? String ?? ""

    }
}

extension MembersViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "取得結果0件\nもしくは取得失敗")
    }

    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "タップして再読み込み")
    }

    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        resetAndLoadApi()
    }
}

