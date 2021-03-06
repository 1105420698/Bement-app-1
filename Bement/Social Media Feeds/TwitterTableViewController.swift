//
//  TwitterTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/27/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import Kingfisher
import FeedKit

/// A `UITableViewController` that helps displaying a list of posts from Twitter.
class TwitterTableViewController: UITableViewController {
    
    /// Keep track of the amount of time this table is reloaded.
    var reloadCount = 0
    
    /// :nodoc:
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// :nodoc:
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// :nodoc:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AppDelegate.twitterItems.count
    }
    
    /// :nodoc:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let datePub = formatter.string(from: AppDelegate.twitterItems[indexPath.row].pubDate!)
        
        let cellWithImage = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as! imageTableViewCell
        
        cellWithImage.selectionStyle = .none
        cellWithImage.dateOfPub.text = "Date: \(datePub)"
        
        if AppDelegate.twitterItems[indexPath.row].title == nil {
            cellWithImage.content.removeFromSuperview()
        } else {
            cellWithImage.content.text = AppDelegate.twitterItems[indexPath.row].title
        }
        
        let processor = RoundCornerImageProcessor(cornerRadius: 15)
        
        if let url = AppDelegate.twitterItems[indexPath.row].enclosure?.attributes!.url {
            cellWithImage.contentImage.kf.setImage(
                with: URL(string: url),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .processor(processor)
                ], completionHandler: { [self] _ in
                    if reloadCount != 5 {
                        reloadCount += 1
                        tableView.reloadData()
                    }
                })
        } else {
            cellWithImage.contentImage.removeFromSuperview()
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        return cellWithImage
    }
    
    /// Stop downloading images when the table is finished displaying.
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellWithImage = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as! imageTableViewCell
        cellWithImage.contentImage.kf.cancelDownloadTask()
    }
    
    /// Automatically determine cell height, no idea if this actually works or not.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    /// Open link when a cell is pressed.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let link = URL(string: AppDelegate.twitterItems[indexPath.row].link!) {
            UIApplication.shared.open(link)
        }
    }
}
