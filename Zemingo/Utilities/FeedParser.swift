//
//  FeedParser.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 08/12/2020.
//

import Foundation
import FeedKit

// Struct that responsible for the procces
// of parsing the data from RSS's Feed to Zemingo's Feed struct
// with the help of a special constructor in Zemingo's Feed struct
struct ZemingoFeedParser {
    func parseFeeds(from rssFeeds:[RSSFeedItem]) throws -> [Feed] {
        return try rssFeeds.map {
            return try Feed(rssFeedItem: $0)
        }
    }
}
