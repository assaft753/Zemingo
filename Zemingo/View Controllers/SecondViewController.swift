//
//  SecondViewController.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import UIKit

// View Controller that represents the second View Controller
class SecondViewController: UIViewController {
    
    // MARK:- Storyboard referenced properties
    @IBOutlet private weak var feedSegmentedControl: UISegmentedControl!
    
    // MARK:- Properties
    weak var pickedFeedDelegate: FeedPickable?
    
    private lazy var carFeedsViewController: CarFeedsViewController = {
        let carFeedsViewController = CarFeedsViewController()
        carFeedsViewController.pickedFeedDelegate = self
        return carFeedsViewController
    }()
    
    private lazy var sportAndCultureFeedsViewController: SportAndCultureFeedsViewController = {
        let sportAndCultureFeedsViewController = SportAndCultureFeedsViewController()
        sportAndCultureFeedsViewController.pickedFeedDelegate = self
        return sportAndCultureFeedsViewController
    }()
    
    // MARK:- View Controller Life-Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK:- Methods
    private func setupViews() {
        setupSegmentedControl()
        add(asChildViewController: carFeedsViewController) // First appeared View Controller.
    }
    
    private func setupSegmentedControl() {
        feedSegmentedControl.addTarget(self, action: #selector(feedSegmentSelected), for: .valueChanged)
    }
    
    @objc private func feedSegmentSelected() {
        updateView()
    }
    
    private func updateView() {
        if feedSegmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: sportAndCultureFeedsViewController)
            add(asChildViewController: carFeedsViewController)
        } else {
            remove(asChildViewController: carFeedsViewController)
            add(asChildViewController: sportAndCultureFeedsViewController)
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        
        viewController.view.removeFromSuperview()
        
        viewController.removeFromParent()
    }
}

// Extension that implements the FeedPickable protocol for events of picking a feed
extension SecondViewController: FeedPickable {
    
    // An helper Method that extract a View Controller from the main storyboard
    private func initStoryboardViewController(with identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController
    }
    
    func feedPicked(feed: Feed) {
        pushFeedDescriptionViewController(feed: feed)
        pickedFeedDelegate?.feedPicked(feed: feed)
    }
    
    // Method responsible for pushing the feedDescriptionViewController in the NavigationViewController's stack view
    func pushFeedDescriptionViewController(feed: Feed) {
        let feedDescriptionViewController = initStoryboardViewController(with: "feedDescriptionViewController") as! FeedDescriptionViewController
        
        feedDescriptionViewController.feedDescription = feed.description
        
        feedDescriptionViewController.navigationItem.title = feed.title
        
        navigationController?.pushViewController(feedDescriptionViewController, animated: true)
    }
    
    
}
