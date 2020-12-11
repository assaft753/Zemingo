//
//  FirstViewController.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import UIKit

// View Controller that represents the first View Controller
class FirstViewController: UIViewController {
    
    // MARK:- Storyboard referenced properties
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var feedLabel: UILabel!
    
    // MARK:- Properties
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    // MARK:- View Controller Life-Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "Assaf Tayouri"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timeLabel.text = "\(dateFormatter.string(from: Date()))"
    }
    
    // MARK:- Methods
    func updateFeedLabel(for feed: Feed) {
        feedLabel.text = "\(feed.title) - \(feed.description)"
    }
}
