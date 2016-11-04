//
//  HomeViewController.swift
//  NoStoryboard
//
//  Created by Kensuke Hoshikawa on 2016/03/27.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import SVProgressHUD
import DZNEmptyDataSet
import MGSwipeTableCell
import SDCAlertView
import FontAwesome_swift
import Toaster
import PullToRefreshSwift

class PostsViewController: UIViewController, UISearchBarDelegate {

    var posts: [Post] = []
    var searchText = ""
    var nextPage: Int? = 1
    var searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        rightBarButton.setTitleTextAttributes(attributes, for: .normal)
        rightBarButton.title = String.fontAwesomeIcon(name: .pencil)
        self.navigationItem.title = searchText != nil ? searchText : "Posts"
        initTableView()
        resetAndLoadApi()
        setSearchBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        // if Global.fromLogin || Global.posted {
        // resetAndLoadApi()
        // Global.fromLogin = false
        // Global.posted = false
        // }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    func setSearchBar() {
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        if #available(iOS 9.1, *) { searchController.obscuresBackgroundDuringPresentation = false }
        searchController.searchBar.text = searchText
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barTintColor = UIColor.esaGreen
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.layer.borderColor = UIColor.esaGreen.cgColor
        searchController.searchBar.layer.borderWidth = 1
        searchController.searchBar.layer.opacity = 1
        searchController.searchBar.subviews[0].subviews.flatMap() { $0 as? UITextField }.first?.tintColor = UIColor.esaGreen
        tableView.tableHeaderView = searchController.searchBar
    }

    func initTableView() {
        tableView.register(R.nib.postTableViewCell(), forCellReuseIdentifier: R.nib.postTableViewCell.name)
        tableView.estimatedRowHeight = 123
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.addPullRefresh { [weak self] in
            self?.resetAndLoadApi()
            self?.tableView.stopPullRefreshEver(false)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchController.searchBar.text!
        resetAndLoadApi()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = ""
    }

    func resetAndLoadApi() {
        posts = []
        tableView.reloadData()
        loadGetPostApi(page: 1)
    }

    func loadGetPostApi(page: Int?) {
        guard let page = page, !SVProgressHUD.isVisible() else {
            log?.warning("not load...")
            return
        }
        SVProgressHUD.showLoading()
        let request = ESAApiClient.GetPostsRequest(page: page, q: searchText)
        ESASession.send(request) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                self.posts += response.posts
                self.nextPage = response.nextPage
                self.navigationItem.title = "\(response.totalCount) Posts"
                self.tableView.reloadData()
            case .failure(let error):
                ESAApiClient.errorHandler(error)
            }
        }
    }

    @IBAction func openEditor(sender: AnyObject) {
        // Window.openEditor(self, post: nil)
    }

}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: R.nib.postTableViewCell.name)! as! PostTableViewCell
        cell.setItems(post: posts[indexPath.row])
        if (posts.count - 1) == indexPath.row {
            loadGetPostApi(page: nextPage)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log?.debug("\(indexPath)")
        // performSegue(withIdentifier: R.segue.dexSelectionListController.toPokemonList, sender: dexPokemonList)
    }

}

extension PostsViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
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

