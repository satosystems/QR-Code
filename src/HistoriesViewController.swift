//
//  HistoriesViewController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 Satoshi Ogata. All rights reserved.
//

import UIKit

class HistoriesViewController: BaseViewController {
    class ScanHistoriesViewController: TableViewController {
        fileprivate let estimatedRowHeight: CGFloat = 100
        weak var parent2: HistoriesViewController! = nil

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ScanHistoryModel.getInstance().loadScanHistories().count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = ScanHistoryModel.getInstance().loadScanHistories()[(indexPath as NSIndexPath).row]
            return cell
        }

        override func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
            parent2.openScanResult(ScanHistoryModel.getInstance().loadScanHistories()[(indexPath as NSIndexPath).row])
        }

        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            ScanHistoryModel.getInstance().removeAtIndex((indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [IndexPath(row: (indexPath as NSIndexPath).row, section: 0)],
                                             with: UITableView.RowAnimation.fade)
        }

        override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return estimatedRowHeight
        }
    }

    var tableView: UITableView! = nil
    var withDetail: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Histories", comment: "履歴")

        navigationItem.rightBarButtonItem = editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if withDetail && tableView != nil {
            tableView.reloadData()
        }
        if tableView == nil {
            let shvc = ScanHistoriesViewController()
            shvc.parent2 = self
            addChild(shvc)
            view.addSubview(shvc.view)
            shvc.didMove(toParent: self)

            shvc.view.frame = view.frame
            tableView = shvc.view as? UITableView
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if withDetail {
            withDetail = false
            let data = ScanHistoryModel.getInstance().loadScanHistories()[0]
            openScanResult(data)
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }

    func openScanResult() {
        withDetail = true
        tabBarController?.selectedIndex = 1
    }

    func openScanResult(_ data: String) {
        let srvc = ScanResultViewController(data: data)
        let nc = UINavigationController(rootViewController: srvc)
        present(nc, animated: true, completion: nil)
    }
}
