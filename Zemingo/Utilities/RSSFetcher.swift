//
//  RSSFetcher.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 08/12/2020.
//

import Foundation
import FeedKit

// Struct that responsible for fetching the RSS's Feeds
// synchronously from a remote server
// using the 3rd party framework - FeedKit
struct RSSFetcher {
    func fetchRSS(from url: URL) throws -> [RSSFeedItem] {
        let result = FeedParser(URL: url).parse()
        
        switch result {
            case .success(let rssData):
                if let rssItems = rssData.rssFeed?.items {
                    return rssItems
                }
                return []
            case .failure(let error):
                throw error
        }
    }
}
