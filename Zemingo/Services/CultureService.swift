//
//  CultureService.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 08/12/2020.
//

import Foundation

// Lazy-initiating singleton final class (no one can inherit from it)
// that responsible for fetching and parsing Culture's Feeds.
// the class is final because it is using 'Self' keyword in the Serviceable protocol
// for the type identification of the shared property.
// Part of the class implementation is in the Serviceable protocol.
final class CultureService: Serviceable {
    
    // MARK:- Static properties
    static let feedUrl: String = "https://www.globes.co.il/webservice/rss/rssfeeder.asmx/FeederNode?iID=3317"
    
    private static var instance: CultureService!
    
    static var shared: CultureService {
        instance = instance ?? CultureService()
        return instance
    }
    
    // MARK:- Properties
    let notificationCenter: NotificationCenter
    var isLoopStarted: Bool
    
    // MARK:- Constructors
    private init() {
        self.notificationCenter = .default
        self.isLoopStarted = false
    }
    
    // MARK:- Methods for sending notification events
    func notifyStartUpdate() {
        notificationCenter.post(name: .cultureUpdateStarted, object: nil)
    }
    
    func notifyFinishUpdate(with feeds: [Feed]) {
        notificationCenter.post(name: .cultureUpdateFinished, object: nil ,userInfo: ["feeds": feeds])
    }
    
    
}
