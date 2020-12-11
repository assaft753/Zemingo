//
//  FeedViewController.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import UIKit

// A base View Controller that implemtents shared functionalities for the inhrited classes.
class FeedViewController: UIViewController {
    
    // MARK:- Properties
    private lazy var feedsTableView: UITableView = {
        let feedsTableView = UITableView(frame: .zero)
        feedsTableView.rowHeight = UITableView.automaticDimension
        feedsTableView.estimatedRowHeight = 100
        return feedsTableView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.isHidden = true
        return spinner
    }()
    
    var feeds: [String: [Feed]] = [:]
    
    weak var pickedFeedDelegate: FeedPickable?
    
    // MARK:- View Controller Life-Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK:- Methods
    private func setupViews() {
        setupFeedTableView()
        setupSpinnerView()
    }
    
    func refreshFeedTableView()
    {
        feedsTableView.reloadData()
    }
    
    private func setupSpinnerView() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupFeedTableView() {
        view.addSubview(feedsTableView)
        feedsTableView.translatesAutoresizingMaskIntoConstraints = false
        feedsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        feedsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        feedsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        feedsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        feedsTableView.delegate = self
        feedsTableView.dataSource = self
        
        feedsTableView.tableFooterView = UIView() // For removing empty rows when table view is empty
        
        feedsTableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: FeedTableViewCell.identifier) // From the xib file
    }
    
    
    func startSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    func extractFeeds(from notification: NSNotification) -> [Feed] {
        guard let remoteFeeds = notification.userInfo?["feeds"] as? [Feed]
        else { return [] }
        return remoteFeeds
    }
    
    private func dequeueFeedReusableCell(for indexPath: IndexPath) -> FeedTableViewCell {
        return feedsTableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
    }
    
    // Default implementations for the feedsTableView's information that is required
    func numOfFeeds(in section: Int) -> Int {
        return 0
    }
    
    func feedCellForItem(_ tableView: UITableView, indexPath: IndexPath) -> FeedTableViewCell {
        return dequeueFeedReusableCell(for: indexPath)
    }
    
    func titleForHeader(_ tableView: UITableView ,in section: Int) -> String? {
        return nil
    }
    
    func numberOfFeedSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func didSelectFeedCell(at indexPath: IndexPath) { }
}

// Extenstion that responsible for implementing
// the delegate and data source of the feedsTableView
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfFeeds(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return feedCellForItem(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectFeedCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                    section: Int) -> String? {
        return titleForHeader(tableView, in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        numberOfFeedSections(in: tableView)
    }
}
