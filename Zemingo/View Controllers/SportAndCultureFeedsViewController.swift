//
//  SportAndCultureFeedsViewController.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import UIKit

// View controller that responsible for presents
// the sport's and culture's feeds
class SportAndCultureFeedsViewController: FeedViewController {
    
    // MARK:- Properties
    private let sportFeedKey = "sport"
    private let cultureFeedKey = "culture"
    
    private let sportFeedTitle = "Sport"
    private let cultureFeedTitle = "Culture"
    
    private let notificationCenter: NotificationCenter = .default
    
    private var accessCounter = 0
    
    // For the barrier functionality for the data updating.
    private var queue = DispatchQueue(label: "sportAndCultureVCQueue", attributes: .concurrent)
    
    // MARK:- View Controller Life-Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        feeds = [sportFeedKey: [], cultureFeedKey: []]
        setupNotificationCenter()
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    // MARK:- Methods
    private func setupNotificationCenter() {
        notificationCenter.addObserver(self,
                                       selector: #selector(handleSportUpdateStarted),
                                       name: .sportUpdateStarted,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(handleSportUpdateFinished(_:)),
                                       name: .sportUpdateFinished,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(handleCultureUpdateStarted),
                                       name: .cultureUpdateStarted,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(handleCultureUpdateFinished(_:)),
                                       name: .cultureUpdateFinished,
                                       object: nil)
    }
    
    @objc private func handleSportUpdateStarted() {
        handleStartUpdatingEvent()
    }
    
    @objc private func handleSportUpdateFinished(_ notification: NSNotification) {
        let remoteFeeds = extractFeeds(from: notification)
        handleFinishUpdatingEvent(feedKey: sportFeedKey, feeds: remoteFeeds)
    }
    
    @objc private func handleCultureUpdateStarted() {
        handleStartUpdatingEvent()
    }
    
    @objc private func handleCultureUpdateFinished(_ notification: NSNotification) {
        let remoteFeeds = extractFeeds(from: notification)
        handleFinishUpdatingEvent(feedKey: cultureFeedKey, feeds: remoteFeeds)
    }
    
    private func handleStartUpdatingEvent() {
        // Thread Safe - no data racing
        queue.sync(flags: .barrier) { [unowned self] in
            if self.accessCounter == 0 { // The first update started
                DispatchQueue.main.async {
                    self.startSpinner()
                }
            }
            
            self.accessCounter += 1
        }
    }
    
    private func handleFinishUpdatingEvent(feedKey: String, feeds: [Feed]) {
        // Thread Safe - no data racing
        queue.sync(flags: .barrier) { [unowned self] in
            self.feeds[feedKey] = feeds
            
            
            DispatchQueue.main.async {
                // One of the test's requirements
                // is to update the UI for each RSS feed that gets updates
                self.refreshFeedTableView()
            }
            
            if self.accessCounter == 1 { // the last update finished
                DispatchQueue.main.async {
                    self.stopSpinner()
                }
            }
            
            self.accessCounter -= 1
        }
    }
    
    // MARK:- Override methods for the feedsTableView's information
    override func numOfFeeds(in section: Int) -> Int {
        if section == 0 {
            return feeds[sportFeedKey]?.count ?? 0
        }
        return feeds[cultureFeedKey]?.count ?? 0
        
    }
    
    override func feedCellForItem(_ tableView: UITableView, indexPath: IndexPath) -> FeedTableViewCell {
        let feedCell = super.feedCellForItem(tableView, indexPath: indexPath)
        
        
        if let feed = feeds[indexPath.section == 0 ?
                                sportFeedKey: cultureFeedKey]?[indexPath.row] {
            feedCell.setFeed(title: feed.title)
            feedCell.setFeed(description: feed.description)
        }
        return feedCell
    }
    
    override func titleForHeader(_ tableView: UITableView, in section: Int) -> String? {
        return section == 0 ? sportFeedTitle : cultureFeedTitle
    }
    
    override func numberOfFeedSections(in tableView: UITableView) -> Int {
        return ((feeds[sportFeedKey] ?? []).isEmpty ? 0 : 1) + ((feeds[cultureFeedKey] ?? []).isEmpty ? 0 : 1)
    }
    
    override func didSelectFeedCell(at indexPath: IndexPath) {
        if let feed = feeds[indexPath.section == 0 ?
                                sportFeedKey: cultureFeedKey]?[indexPath.row] {
            pickedFeedDelegate?.feedPicked(feed: feed)
        }
    }
}
