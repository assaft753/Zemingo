//
//  FeedPickable.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import Foundation

// Protocol (Using as delegate design pattern) for events of picking a feed
protocol FeedPickable: class {
    func feedPicked(feed: Feed)
}

