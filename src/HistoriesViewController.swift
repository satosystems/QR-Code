//
//  HistoriesViewController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

class HistoriesViewController: BaseViewController {
    class ScanHistoriesViewController: TableViewController {
        private let estimatedRowHeight: CGFloat = 100
        weak var parent: HistoriesViewController! = nil

        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ScanHistoryModel.getInstance().loadScanHistories().count
        }

        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = ScanHistoryModel.getInstance().loadScanHistories()[indexPath.row]
            return cell
        }

        override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
            parent.openScanResult(ScanHistoryModel.getInstance().loadScanHistories()[indexPath.row])
        }

        override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
        }

        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            ScanHistoryModel.getInstance().removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)],
                                             withRowAnimation: UITableViewRowAnimation.Fade)
        }

        override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return estimatedRowHeight
        }
    }

    var tableView: UITableView! = nil
    var withDetail: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Histories", comment: "履歴")

        navigationItem.rightBarButtonItem = editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if withDetail && tableView != nil {
            tableView.reloadData()
        }
        if tableView == nil {
            let shvc = ScanHistoriesViewController()
            shvc.parent = self
            addChildViewController(shvc)
            view.addSubview(shvc.view)
            shvc.didMoveToParentViewController(self)

            shvc.view.frame = view.frame
            tableView = shvc.view as! UITableView
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if withDetail {
            withDetail = false
            let data = ScanHistoryModel.getInstance().loadScanHistories()[0]
            openScanResult(data)
        }
    }

    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.editing = editing
    }

    func openScanResult() {
        withDetail = true
        let delegate = tabBarController?.delegate
        delegate!.tabBarController!(tabBarController!, shouldSelectViewController: self)
    }

    func openScanResult(data: String) {
        let srvc = ScanResultViewController(data: data)
        let nc = UINavigationController(rootViewController: srvc)
        presentViewController(nc, animated: true, completion: nil)
    }
}
