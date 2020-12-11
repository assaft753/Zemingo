//
//  FeedTableViewCell.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import UIKit

// Class that represents Feed's table view cell
class FeedTableViewCell: UITableViewCell {
    static let identifier = "feedCell"
    
    @IBOutlet private weak var feedTitleLabel: UILabel!
    
    @IBOutlet private weak var feedDescriptionLabel: UILabel!
    
    // MARK:- Methods for updating cell's UI components
    func setFeed(title: String) {
        feedTitleLabel.text = title
    }
    
    func setFeed(description: String) {
        feedDescriptionLabel.text = description
    }
    
}
