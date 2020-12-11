//
//  ViewController.swift
//  Zemingo
//
//  Created by Assaf Tayouri on 07/12/2020.
//

import UIKit

// View Controller Class is the app's start point and contains
// the First View Controller and the Second Navigation View Controller as children.
// each View Controller child has its tab
class MainTabViewController: UITabBarController {
    
    // MARK:- Properties
    private lazy var firstViewController: FirstViewController = {
        let firstViewController = initStoryboardViewController(with: "firstViewController") as! FirstViewController
        
        firstViewController.tabBarItem.title = "first"
        firstViewController.tabBarItem.image = #imageLiteral(resourceName: "first")
        
        return firstViewController
    }()
    
    private lazy var secondNavViewController: UINavigationController = {
        let secondNavViewController = initStoryboardViewController(with: "secondNavViewController") as! UINavigationController
        
        secondNavViewController.tabBarItem.title = "second"
        secondNavViewController.tabBarItem.image = #imageLiteral(resourceName: "second")
        
        (secondNavViewController.topViewController as! SecondViewController).pickedFeedDelegate = self
        
        return secondNavViewController
    }()
    
    // MARK:- View Controller Life-Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupServices()
    }
    
    // MARK:- Methods
    private func setupServices() {
        CarService.shared.startLoop()
        SportService.shared.startLoop()
        CultureService.shared.startLoop()
    }
    
    private func setupTabs() {
        viewControllers = [firstViewController, secondNavViewController]
    }
    
    // An helper Method that extract a View Controller from the main storyboard
    private func initStoryboardViewController(with identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController
    }
}

// Extension that implements the FeedPickable protocol for events of picking a feed
extension MainTabViewController: FeedPickable {
    func feedPicked(feed: Feed) {
        firstViewController.updateFeedLabel(for: feed)
    }
}

