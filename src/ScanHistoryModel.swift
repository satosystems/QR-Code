//
//  ScanHistoryModel.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/17.
//  Copyright © 2016年 Satoshi Ogata. All rights reserved.
//

import Foundation

class ScanHistoryModel {
    fileprivate let key = "histories"
    fileprivate static let singleton = ScanHistoryModel()
    var histories: [String]?

    static func getInstance() -> ScanHistoryModel {
        return singleton
    }

    func addScanHistory(_ data: String) {
        if (histories == nil) {
            histories = loadScanHistories()
        }
        histories?.insert(data, at: 0)

        if !uniqIfNeeded() {
            let userDefaults = UserDefaults.standard
            userDefaults.set(histories, forKey: key)
            userDefaults.synchronize()
        }
    }

    func loadScanHistories() -> [String] {
        if (histories != nil) {
            return histories!
        }
        let userDefaults = UserDefaults.standard
        histories = userDefaults.stringArray(forKey: key)
        if (histories == nil) {
            histories = []
        }
        return histories!
    }

    func removeAtIndex(_ index: Int) {
        histories?.remove(at: index)
        let userDefaults = UserDefaults.standard
        userDefaults.set(histories, forKey: key)
        userDefaults.synchronize()
    }

    func uniqIfNeeded() -> Bool {
        let userDefaults = UserDefaults.standard
        let updated = userDefaults.bool(forKey: AppDelegate.summarizing)
        if updated && histories != nil {
            histories = histories?.uniq()
            userDefaults.set(histories, forKey: key)
            userDefaults.synchronize()
        }
        return updated
    }
}
