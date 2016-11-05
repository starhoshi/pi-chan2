//
//  SettingsViewController.swift
//  pi-chan
//
//  Created by Kensuke Hoshikawa on 2016/03/27.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import UIKit
import FontAwesome_swift

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
        closeButton.setTitleTextAttributes(attributes, for: .normal)
        closeButton.title = String.fontAwesomeIcon(name: .close)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(R.nib.settingTableViewCell(), forCellReuseIdentifier: R.nib.settingTableViewCell.name)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionList[section].cellContents.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.settingTableViewCell.name) as! SettingTableViewCell
        cell.settingViewController = self
        cell.setItems(cellContent: sectionList[indexPath.section].cellContents[indexPath.row])
        return cell
    }

    @IBAction func close(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
