//
//  Serviceable.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import Foundation

// Protocol for the Feed singleton services
protocol Serviceable: class {
    
    // MARK:- Static properties
    
    // The URL of the remote server RSS Feeds
    static var feedUrl: String { get }
    
    // Property for lazily initiating the singleton.
    // the 'Self' keyword make the class
    // that conforms this protocol to be a final class
    static var shared:  Self { get }
    
    // MARK:- Properties
    
    // Notification Center for sending updating events
    var notificationCenter: NotificationCenter { get }
    
    // Indicator boolean property for preventing start
    // the loop again after it already started
    var isLoopStarted: Bool { get set }
    
    // MARK:- Methods
    // Method that responsible for starting the looper only once
    func startLoop()
    
    // Method that responsible for fetching and parsing the RSS Feeds
    func fetchFeeds()
    
    // Method that responsible for sending start updating
    // event using the notification center to the observers.
    func notifyStartUpdate()
    
    // Method that responsible for sending finish updating
    // event with the relevant feeds
    // using the notification center to the observers.
    func notifyFinishUpdate(with feeds: [Feed])
}

// Extension that implement part of the Serviceable protocol.
// acting similarly like an abstract class,
// generic implementation for all conformed classes.
extension Serviceable {
    
    // MARK:- Methods
    func startLoop() {
        if !isLoopStarted {
            isLoopStarted = true
            loop()
        }
    }
    
    private func loop() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + 5) {
            [weak self] in
            self?.fetchFeeds()
            self?.loop()
        }
    }
    
    func fetchFeeds() {
        notifyStartUpdate()
        if let feedUrl = URL(string: Self.feedUrl),
           let rssItems = try? RSSFetcher().fetchRSS(from: feedUrl),
           let feeds = try? ZemingoFeedParser().parseFeeds(from: rssItems) {
            notifyFinishUpdate(with: feeds)
        } else {
            notifyFinishUpdate(with: [])
        }
    }
}


