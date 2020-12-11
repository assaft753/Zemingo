//
//  FeedDescriptionViewController.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import UIKit

// View Controller that presents the feed description
class FeedDescriptionViewController: UIViewController {
    
    // MARK:- Storyboard referenced properties
    @IBOutlet private weak var feedDescriptionTextView: UITextView!
    
    // MARK:- Properties
    var feedDescription: String!
    
    // MARK:- View Controller Life-Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedDescriptionTextView()
        
    }
    
    // MARK:- Methods
    private func setupFeedDescriptionTextView() {
        feedDescriptionTextView.text = feedDescription
    }
}
