//
//  ViewController.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: PostsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = PostsDataSource(observer: self)
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib(nibName: RedditPostTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RedditPostTableViewCell.identifier)
        self.tableView.register(UINib(nibName: SpinnerTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SpinnerTableViewCell.identifier)
    }

}

extension ViewController: DataSourceObserver {
    
    func dataSourceUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func dataSourceFailed() {
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let spinnerCell = cell as? SpinnerTableViewCell {
            spinnerCell.activityIndicator.startAnimating()
            
            self.dataSource.loadNextPage()
        }
    }
    
}
