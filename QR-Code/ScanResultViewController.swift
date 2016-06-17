//
//  ScanResultViewController.swift
//  QR-Code
//
//  Created by Satoshi Ogata on 2016/06/17.
//  Copyright © 2016年 App research and development. All rights reserved.
//

import UIKit

class ScanResultViewController: BaseViewController {
    class ActionsTableViewController: TableViewController {
        var data: String
        var isScheme: Bool = false
        var actions: [String] = [
            "Copy to Clipboard",
            ]

        init(data: String) {
            self.data = data
            do {
                let regexp = try NSRegularExpression(pattern: "^[a-z+.-]+://", options: [])
                isScheme = regexp.numberOfMatchesInString(data,
                                                          options: [],
                                                          range: NSMakeRange(0, data.characters.count)) > 0
            } catch {
                // never come here
            }

            if isScheme {
                actions.insert("Open in App", atIndex: 0)
            }

            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return actions.count
        }

        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = actions[indexPath.row]
            return cell
        }

        override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
            if indexPath.row == actions.count - 1 {
                let pasteboard = UIPasteboard.generalPasteboard()
                pasteboard.setValue(data, forPasteboardType: "public.text")

                view.makeToast("Data of QR Code has been copied to clipboard.")
            } else {
                if let url = NSURL(string: data) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
        }
    }

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

        title = "Scan Result"

        let button = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(ScanResultViewController.onClick))
        navigationItem.rightBarButtonItem = button

        let statusBarHeight = SizeUtils.statusBarHeight()

        var y = margin + statusBarHeight

        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = UIScrollView()
        let lines = CGFloat(6)
        let scrollViewHeight = label.font.pointSize * lines

        scrollView.frame = CGRect(x: margin,
                             y: y,
                             width: view.frame.width - margin * 2,
                             height: scrollViewHeight)

        view.addSubview(scrollView)
        scrollView.addSubview(label)

        label.text = data

        scrollView.addConstraints([
            NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .Left, relatedBy: .Equal, toItem: scrollView, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .Bottom, relatedBy: .Equal, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0),
            ])

        scrollView.backgroundColor = UIColor.whiteSmokeColor()

        y += scrollViewHeight + margin

        let avc = ActionsTableViewController(data: data)
        addChildViewController(avc)
        view.addSubview(avc.view)
        avc.view.frame = CGRect(x: 0,
                                y: 0,
                                width: view.frame.width,
                                height: view.frame.height)
        avc.didMoveToParentViewController(self)

        avc.view.frame = CGRect(x: 0,
                                y: y,
                                width: view.frame.width,
                                height: view.frame.height - y)
    }

    func onClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
