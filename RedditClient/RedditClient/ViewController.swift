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
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib(nibName: RedditPostTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RedditPostTableViewCell.identifier)
    }

}

extension ViewController: DataSourceObserver {
    
    func dataSourceUpdated() {
        tableView.reloadData()
        
        if tableView.visibleCells.count > 0 {
            tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func dataSourceFailed() {
        
    }
    
}
