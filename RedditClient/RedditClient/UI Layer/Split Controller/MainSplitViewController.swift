//
//  MainSplitViewController.swift
//  RedditClient
//
//  Created by Julian Astrada on 22/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

class MainSplitViewController: UISplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
}

// MARK: - UISplitViewControllerDelegate

extension MainSplitViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}

// MARK: - PostListingDelegate

extension MainSplitViewController: PostListingDelegate {
    
    func didSelectPost(post: RedditPost?) {
        if self.isCollapsed {
            guard let detailVC = UIStoryboard(name: postDetailStoryboard, bundle: nil).instantiateInitialViewController() as? PostDetailViewController, let navVC = self.viewControllers[0] as? UINavigationController, let selected = post else {
                return
            }
            
            detailVC.post = selected
            
            navVC.pushViewController(detailVC, animated: true)
        } else {
            guard let detailVC = self.viewControllers[1] as? PostDetailViewController else {
                return
            }
            
            detailVC.post = post
            detailVC.refreshUI()
        }
    }
    
}
