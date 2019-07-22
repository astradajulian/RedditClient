//
//  ViewController.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

protocol PostListingDelegate: NSObject {
    func didSelectPost(post: RedditPost?)
}

class PostListingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: PostsDataSource!
    
    private let refreshControl = UIRefreshControl()
    
    weak var delegate: PostListingDelegate?
    
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

    @IBAction func dismissAllButtonPressed(_ sender: Any) {
        self.dataSource.posts.removeAll()
        
        self.tableView.reloadData()
    }
}

// MARK: - DataSourceObserver

extension PostListingViewController: DataSourceObserver {
    
    func dataSourceUpdated() {
        DispatchQueue.main.async {[weak self] in
            self?.refreshControl.endRefreshing()
            
            self?.tableView.reloadData()
        }
    }
    
    func dataSourceFailed() {
        DispatchQueue.main.async {[weak self] in
            self?.refreshControl.endRefreshing()
            
            let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("An error ocurred trying to retrieve the data", comment: "Error message"), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self?.present(alert, animated: true, completion: nil)
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
        self.delegate?.didSelectPost(post: self.dataSource.posts[indexPath.row])
        self.dataSource.posts[indexPath.row].unseen = false

        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

// MARK: - RedditPostCellDelegate

extension PostListingViewController: RedditPostCellDelegate {
    
    func thumbnailPressed(cell: RedditPostTableViewCell) {
        guard let fullNVC = UIStoryboard(name: fullScreenURLStoryboard, bundle: nil).instantiateInitialViewController() as? UINavigationController, let fullVC = fullNVC.topViewController as? FullScreenURLViewController, let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        fullVC.post = self.dataSource.posts[indexPath.row]
        
        self.navigationController?.pushViewController(fullVC, animated: true)
    }
    
    func dismissed(cell: RedditPostTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        self.dataSource.posts.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .right)
        self.delegate?.didSelectPost(post: nil)
    }
    
}
