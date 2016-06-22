//
//  ScanResultViewController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/17.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

class ScanResultViewController: BaseViewController {
    var data: String = ""

    init(data: String) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Scan Result", comment: "Scan Result")

        let button = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(ScanResultViewController.onClick))
        navigationItem.rightBarButtonItem = button

        var y: CGFloat = 0
        y += SizeUtils.statusBarHeight()
        y += SizeUtils.navigationBarHeight(navigationController!)
        y += margin

        addLabel(NSLocalizedString("Data", comment: "Data"), y: &y)

        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = data

        label.frame = CGRect(x: margin,
                             y: y,
                             width: view.frame.width - margin * 2,
                             height: 0)

        label.sizeToFit()

        y += label.frame.height + margin

        view.addSubview(label)

        y += margin
        addLabel(NSLocalizedString("Actions", comment: "Actions"), y: &y)

        if isScheme(data) {
            addButton(NSLocalizedString("Open in App", comment: "Open in App"), y: &y, action: #selector(ScanResultViewController.openInApp))
        }
        addButton(NSLocalizedString("Copy to Clipboard", comment: "Copy to Clipboard"), y: &y, action: #selector(ScanResultViewController.copyToClipboard))

        addButton(NSLocalizedString("Share", comment: "Share"), y: &y, action: #selector(ScanResultViewController.share))
    }

    func onClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func openInApp() {
        if let url = NSURL(string: data) {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    func copyToClipboard() {
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.setValue(data, forPasteboardType: "public.text")

        view.makeToast(NSLocalizedString("Data of QR Code has been copied to clipboard.", comment: "Data of QR Code has been copied to clipboard."))
    }

    func share() {
        let avc = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        presentViewController(avc, animated: true, completion: nil)
    }

    private func isScheme(data: String) -> Bool {
        do {
            let regexp = try NSRegularExpression(pattern: "^[a-z+.-]+://", options: [])
            return regexp.numberOfMatchesInString(data,
                                                  options: [],
                                                  range: NSMakeRange(0, data.characters.count)) > 0
        } catch {
            // never come here
        }
        return false
    }

    private func addButton(title: String, inout y: CGFloat, action: Selector) {
        let frame = CGRect(x: margin, y: y, width: view.frame.width - margin * 2, height: buttonHeight)
        let button = CustomButton(frame: frame)
        button.setTitle(title, forState: UIControlState.Normal)
        button.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        y += buttonHeight + margin
    }

    private func addLabel(title: String, inout y: CGFloat) {
        let frame = CGRect(x: margin, y: y, width: view.frame.width - margin * 2, height: labelHeight)
        let label = UILabel(frame: frame)
        label.text = title
        label.font = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
        view.addSubview(label)
        y += labelHeight + margin
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
