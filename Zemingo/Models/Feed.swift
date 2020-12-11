//
//  Feed.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import Foundation
import FeedKit

// Struct that represent Zemingo's App Feed
struct Feed {
    
    // MARK:- Properties
    var title: String
    var description: String
    
    // MARK:- Constructors
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    init(rssFeedItem: RSSFeedItem) throws {
        if let rssFeedTitle = rssFeedItem.title,
           let rssFeedDescription = rssFeedItem.description {
            self.init(title: rssFeedTitle, description: rssFeedDescription)
        } else {
            throw FeedError.noFeedDataError
        }
    }
}
