//
//  NotificationName.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import Foundation

// Extension that adds notification event identifiers
extension Notification.Name {
    static var carUpdateStarted: Notification.Name {
        return Notification.Name.init(rawValue: "carUpdateStarted")
    }
    
    static var carUpdateFinished: Notification.Name {
        return Notification.Name.init(rawValue: "carUpdateFinished")
    }
    
    static var sportUpdateStarted: Notification.Name {
        return Notification.Name.init(rawValue: "sportUpdateStarted")
    }
    
    static var sportUpdateFinished: Notification.Name {
        return Notification.Name.init(rawValue: "sportUpdateFinished")
    }
    
    static var cultureUpdateStarted: Notification.Name {
        return Notification.Name.init(rawValue: "cultureUpdateStarted")
    }
    
    static var cultureUpdateFinished: Notification.Name {
        return Notification.Name.init(rawValue: "cultureUpdateFinished")
    }
}
