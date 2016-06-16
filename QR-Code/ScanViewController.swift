//
//  ScanViewController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/16.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import AVFoundation
import UIKit

extension ZBarSymbolSet: SequenceType {
    public func generate() -> NSFastGenerator {
        return NSFastGenerator(self)
    }
}

class ScanViewController: ZBarReaderViewController, ZBarReaderViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        readerView.readerDelegate = self
        showsCameraControls = false
        showsZBarControls = false
        tracksSymbols = true
        readerView.torchMode = AVCaptureTorchMode.Off.rawValue
        readerView.frame = view.frame
    }

    func readerView(readerView: ZBarReaderView!, didReadSymbols symbols: ZBarSymbolSet!, fromImage image: UIImage!) {
            for symbol in symbols {
                print(symbol.data as String)  // FIXME: remove
                break;
            }
    }

}
