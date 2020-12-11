//
//  CarService.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import Foundation

// Lazy-initiating singleton final class (no one can inherit from it)
// that responsible for fetching and parsing Car's Feeds.
// the class is final because it is using 'Self' keyword in the Serviceable protocol
// for the type identification of the shared property.
// Part of the class implementation is in the Serviceable protocol.
final class CarService: Serviceable {
    
    // MARK:- Static properties
    static let feedUrl = "https://www.globes.co.il/webservice/rss/rssfeeder.asmx/FeederNode?iID=3220"
    
    private static var instance: CarService!
    
    static var shared: CarService {
        instance = instance ?? CarService()
        return instance
    }
    
    // MARK:- properties
    let notificationCenter: NotificationCenter
    var isLoopStarted: Bool
    
    // MARK:- constructors
    private init() {
        self.notificationCenter = .default
        self.isLoopStarted = false
    }
    
    // MARK:- Methods for sending notification events
    func notifyStartUpdate() {
        notificationCenter.post(name: .carUpdateStarted, object: nil)
    }
    
    func notifyFinishUpdate(with feeds: [Feed]) {
        notificationCenter.post(name: .carUpdateFinished, object: nil ,userInfo: ["feeds": feeds])
    }
}
