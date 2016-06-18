//
//  ScanHistoryModel.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/17.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import Foundation

class ScanHistoryModel {
    private let key = "histories"
    private static let singleton = ScanHistoryModel()
    var histories: [String]?

    static func getInstance() -> ScanHistoryModel {
        return singleton
    }

    func addScanHistory(data: String) {
        if (histories == nil) {
            histories = loadScanHistories()
        }
        histories?.insert(data, atIndex: 0)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(histories, forKey: key)
        userDefaults.synchronize()
    }

    func loadScanHistories() -> [String] {
        if (histories != nil) {
            return histories!
        }
        let userDefaults = NSUserDefaults.standardUserDefaults()
        histories = userDefaults.stringArrayForKey(key)
        if (histories == nil) {
            histories = []
        }
        return histories!
    }

    func removeAtIndex(index: Int) {
        histories?.removeAtIndex(index)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(histories, forKey: key)
        userDefaults.synchronize()
    }
}
