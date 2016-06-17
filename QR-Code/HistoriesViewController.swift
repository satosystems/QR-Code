//
//  HistoriesViewController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

class HistoriesViewController: UIViewController {
    class ScanHistoriesViewController: TableViewController {
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        let shvc = ScanHistoriesViewController()
        shvc.parent = self
        addChildViewController(shvc)
        view.addSubview(shvc.view)
        shvc.didMoveToParentViewController(self)

        let statusBarHeight = SizeUtils.statusBarHeight()
        let tabBarHeight = SizeUtils.tabBarHeight(tabBarController!)
        shvc.view.frame = CGRect(x: 0,
                                 y: statusBarHeight,
                                 width: view.frame.width,
                                 height: view.frame.height - statusBarHeight - tabBarHeight)
    }

    func openScanResult(data: String) {
        let srvc = ScanResultViewController(data: data)
        presentViewController(srvc, animated: true, completion: nil)
    }
}
