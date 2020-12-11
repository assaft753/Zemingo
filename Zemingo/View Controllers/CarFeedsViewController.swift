//
//  CarFeedsViewController.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import UIKit

// View controller that responsible for presents
// the car's feeds
class CarFeedsViewController: FeedViewController {
    
    // MARK:- Properties
    private let carsFeedKey = "cars"
    
    private let notificationCenter: NotificationCenter = .default
    
    // MARK:- View Controller Life-Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationCenter()
        feeds = [carsFeedKey: []]
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    // MARK:- Methods
    private func setupNotificationCenter() {
        notificationCenter.addObserver(self,
                                       selector: #selector(handleCarUpdateStarted),
                                       name: .carUpdateStarted,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(handleCarUpdateFinished(_:)),
                                       name: .carUpdateFinished,
                                       object: nil)
    }
    
    
    
    @objc private func handleCarUpdateStarted() {
        DispatchQueue.main.async { [weak self] in
            self?.startSpinner()
        }
    }
    
    @objc private func handleCarUpdateFinished(_ notification: NSNotification) {
        let remoteFeeds = extractFeeds(from: notification)
        feeds[carsFeedKey] = remoteFeeds
        DispatchQueue.main.async { [weak self] in
            self?.refreshFeedTableView()
            self?.stopSpinner()
        }
    }
    
    // MARK:- Override methods for the feedsTableView's information
    override func numOfFeeds(in section: Int) -> Int {
        return feeds[carsFeedKey]?.count ?? 0
    }
    
    override func feedCellForItem(_ tableView: UITableView, indexPath: IndexPath) -> FeedTableViewCell {
        let feedCell = super.feedCellForItem(tableView, indexPath: indexPath)
        
        if let feed = feeds[carsFeedKey]?[indexPath.row] {
            feedCell.setFeed(title: feed.title)
            feedCell.setFeed(description: feed.description)
        }
        return feedCell
    }
    
    override func didSelectFeedCell(at indexPath: IndexPath) {
        if let feed = feeds[carsFeedKey]?[indexPath.row] {
            pickedFeedDelegate?.feedPicked(feed: feed)
        }
    }
}
