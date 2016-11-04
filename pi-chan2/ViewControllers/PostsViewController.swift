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

class PostsViewController: UIViewController, UISearchBarDelegate {

    // var posts: [Post] = []
    var searchText: String? = nil
    var nextPage: Int? = 1
    var loading = false
    var searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // rightBarButton.setFAIcon(.FAPencil, iconSize: 22)
        self.navigationItem.title = searchText != nil ? searchText : "Posts"
        initTableView()
        // resetAndLoadApi()
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
            // tableView.deselectRowAtIndexPath(indexPathForSelectedRow, animated: true)
        }
    }
    func setSearchBar() {
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        // searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.text = searchText
        // searchController.searchBar.searchBarStyle = UISearchBarStyle.Default
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
        let postCellNib: UINib = UINib(nibName: "PostTableViewCell", bundle: nil)
        // tableView.registerNib(postCellNib, forCellReuseIdentifier: "PostCell")
        tableView.estimatedRowHeight = 123
        tableView.rowHeight = UITableViewAutomaticDimension
        // self.tableView.tableFooterView = UIView()
        // tableView.dg_addPullToRefreshWithActionHandler({ [weak self]() -> Void in
        // self!.tableView.dg_stopLoading()
        // self!.resetAndLoadApi()
        // }, loadingView: View.refreshLoading())
        // tableView.dg_setPullToRefreshFillColor(UIColor.esaGreen())
        // tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchText = searchController.searchBar.text
        // resetAndLoadApi()
    }

    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "取得結果0件\nもしくは取得失敗")
    }

    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "タップして再取得")
    }

    func emptyDataSetDidTapView(scrollView: UIScrollView!) {
        // resetAndLoadApi()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return posts.count
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell")! as! PostTableViewCell
        // cell.setItems(posts[indexPath.row])
        // let deleteIcon = UIImage(icon: .FATrash, size: CGSize(width: 45, height: 45)).fillAlpha(.whiteColor())
        // cell.rightButtons = [MGSwipeButton(title: "", icon: deleteIcon, backgroundColor: UIColor.redColor(), callback: { (sender: MGSwipeTableCell!) -> Bool in
        // self.deletePosts(self.posts[indexPath.row])
        // return true
        // })]
        // cell.rightSwipeSettings.transition = MGSwipeTransition.ClipCenter
        // if (posts.count - 1) == indexPath.row {
        // loadPostApi(nextPage)
        // }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // performSegueWithIdentifier("PostsToPreview", sender: posts[indexPath.row].number)
    }

    // override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // let previewViewController: PreviewViewController = segue.destinationViewController as! PreviewViewController
    // previewViewController.postNumber = sender as! Int
    // }

    // func deletePosts(post: Post) {
    // let alert = AlertController(title: "記事削除", message: "\(post.fullName) を本当に削除しますか？", preferredStyle: .Alert)
    // alert.addAction(AlertAction(title: "削除する", style: .Preferred) {
    // _ in self.loadDeleteApi(post)
    // })
    // alert.addAction(AlertAction(title: "キャンセル", style: .Default))
    // alert.present()
    // }

    // func resetAndLoadApi() {
    // posts = []
    // tableView.reloadData()
    // loadPostApi(1)
    // }

    // func loadPostApi(page: Int?) {
    // if page == nil || loading {
    // return
    // }
    // loading = true
    // SVProgressHUD.showWithStatus("Loading...")
    // Esa(token: KeychainManager.getToken()!, currentTeam: KeychainManager.getTeamName()!).posts(page, q: searchText) { result in
    // SVProgressHUD.dismiss()
    // switch result {
    // case .Success(let posts):
    // self.posts << posts.posts
    // self.nextPage = posts.nextPage
    // self.tableView.reloadData()
    // case .Failure(let error):
    // ErrorHandler.errorAlert(error, controller: self)
    // }
    // self.loading = false
    // }
    // }

    // func loadDeleteApi(post: Post) {
    // loading = true
    // SVProgressHUD.showWithStatus("Loading...")
    // Esa(token: KeychainManager.getToken()!, currentTeam: KeychainManager.getTeamName()!).deletePost(post.number) { result in
    // SVProgressHUD.dismiss()
    // self.loading = false
    // switch result {
    // case .Success(_):
    // self.resetAndLoadApi()
    // JLToast.showPichanToast("記事を削除しました (\\( ⁰⊖⁰)/)")
    // case .Failure(let error):
    // ErrorHandler.errorAlert(error, controller: self)
    // }
    // }
    // }

    @IBAction func openEditor(sender: AnyObject) {
        // Window.openEditor(self, post: nil)
    }

}
