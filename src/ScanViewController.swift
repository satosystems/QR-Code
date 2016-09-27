//
//  ScanViewController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import AVFoundation
import UIKit

class ScanViewController: ZBarReaderViewController, ZBarReaderViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        readerView.readerDelegate = self
        showsCameraControls = false
        showsZBarControls = false
        tracksSymbols = true
        readerView.torchMode = AVCaptureTorchMode.off.rawValue
        readerView.frame = view.frame
    }

    func readerView(_ readerView: ZBarReaderView!, didRead symbols: ZBarSymbolSet!, from image: UIImage!) {
        var data = ""
        for symbol in symbols {
            data += (symbol as AnyObject).data
        }
        ScanHistoryModel.getInstance().addScanHistory(data as String)

        let nc = tabBarController?.viewControllers![1] as! UINavigationController
        let hvc = nc.childViewControllers[0] as! HistoriesViewController
        hvc.openScanResult()
    }
}
