//
//  ViewController.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

class PostListingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: PostsDataSource!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = PostsDataSource(observer: self)
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.refreshControl = self.refreshControl
        self.tableView.register(UINib(nibName: RedditPostTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RedditPostTableViewCell.identifier)
        self.tableView.register(UINib(nibName: SpinnerTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SpinnerTableViewCell.identifier)
        
        self.refreshControl.tintColor = .white
        self.refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
    }
    
    @objc private func refreshTableView(_ sender: Any) {
        self.dataSource.loadTopPosts()
    }

}

// MARK: - DataSourceObserver

extension PostListingViewController: DataSourceObserver {
    
    func dataSourceUpdated() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            
            self.tableView.reloadData()
        }
    }
    
    func dataSourceFailed() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            
            //TODO Error handling
        }
    }
    
}

// MARK: - UITableViewDelegate

extension PostListingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let spinnerCell = cell as? SpinnerTableViewCell {
            spinnerCell.activityIndicator.startAnimating()
            
            self.dataSource.loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dataSource.posts[indexPath.row].unseen = false
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
        guard let detailNVC = UIStoryboard(name: postDetailStoryboard, bundle: nil).instantiateInitialViewController() as? UINavigationController, let detailVC = detailNVC.topViewController as? PostDetailViewController else {
            return
        }
        
        detailVC.post = self.dataSource.posts[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
