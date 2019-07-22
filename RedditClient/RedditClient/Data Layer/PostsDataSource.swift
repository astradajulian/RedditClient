//
//  PostsDataSource.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

protocol DataSourceObserver {
    func dataSourceUpdated()
    func dataSourceFailed()
}

class PostsDataSource: NSObject {

    var observer : DataSourceObserver
    var posts : [RedditPost]
    
    init(observer: DataSourceObserver) {
        self.observer = observer
        self.posts = []
        
        super.init()
        
        loadTopPosts()
    }
    
    func loadTopPosts(){
        DataManager.sharedInstance.getTopPosts(success: {[weak self] (posts) in
            self?.posts = posts
            
            DispatchQueue.main.async{
                self?.observer.dataSourceUpdated()
            }
        }) { [weak self] in
            self?.observer.dataSourceUpdated()
        }
    }
    
    func loadNextPage() {
        DataManager.sharedInstance.getNextPagePosts(success: {[weak self] (posts) in
            self?.posts.append(contentsOf: posts)
            
            self?.observer.dataSourceUpdated()
        }) {[weak self] in
            self?.observer.dataSourceFailed()
        }
    }
    
}

extension PostsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count + (DataManager.sharedInstance.isNextPageAvailable() && self.posts.count != 0 ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < posts.count else {
            guard let spinnerCell = tableView.dequeueReusableCell(withIdentifier: SpinnerTableViewCell.identifier) else {
                return UITableViewCell()
            }
            
            return spinnerCell
        }
        
        guard let postCell : RedditPostTableViewCell = tableView.dequeueReusableCell(withIdentifier: RedditPostTableViewCell.identifier) as? RedditPostTableViewCell else {
            return UITableViewCell()
        }
        
        postCell.delegate = observer as? RedditPostCellDelegate
        postCell.setupCell(post: posts[indexPath.row])
        
        return postCell
    }
    
}
