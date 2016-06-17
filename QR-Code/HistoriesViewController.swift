//
//  HistoriesViewController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

class HistoriesViewController: TableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScanHistoryModel.getInstance().loadScanHistories().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = ScanHistoryModel.getInstance().loadScanHistories()[indexPath.row]
        return cell
    }

    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        openScanResult(ScanHistoryModel.getInstance().loadScanHistories()[indexPath.row])
    }

    func openScanResult(data: String) {
        print("openScanResult")  // FIXME: remove
    }
}
