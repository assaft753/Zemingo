//
//  SportService.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 08/12/2020.
//

import Foundation

// Lazy-initiating singleton final class (no one can inherit from it)
// that responsible for fetching and parsing Sport's Feeds.
// the class is final because it is using 'Self' keyword in the Serviceable protocol
// for the type identification of the shared property.
// Part of the class implementation is in the Serviceable protocol.
final class SportService: Serviceable {
    
    // MARK:- Static properties
    static let feedUrl = "https://www.globes.co.il/webservice/rss/rssfeeder.asmx/FeederNode?iID=2605"
    
    private static var instance: SportService!
    
    static var shared: SportService {
        instance = instance ?? SportService()
        return instance
    }
    
    // MARK:- properties
    let notificationCenter: NotificationCenter
    var isLoopStarted: Bool
    
    // MARK:- Constructors
    private init() {
        self.notificationCenter = .default
        self.isLoopStarted = false
    }
    
    // MARK:- Methods for sending notification events
    func notifyStartUpdate() {
        notificationCenter.post(name: .sportUpdateStarted, object: nil)
    }
    
    func notifyFinishUpdate(with feeds: [Feed]) {
        notificationCenter.post(name: .sportUpdateFinished, object: nil ,userInfo: ["feeds": feeds])
    }
}
