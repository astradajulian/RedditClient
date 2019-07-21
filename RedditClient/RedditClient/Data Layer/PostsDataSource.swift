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
        
        loadTopStories()
    }
    
    func loadTopStories(){
        DataManager.sharedInstance.getTopEntries(success: {[weak self] (posts) in
            self?.posts = posts
            
            DispatchQueue.main.async{
                self?.observer.dataSourceUpdated()
            }
        }) { [weak self] in
            self?.observer.dataSourceUpdated()
        }
    }
    
    func loadNextPage() {
        DataManager.sharedInstance.getNextPageEntries(success: {[weak self] (posts) in
            self?.posts = posts
            
            self?.observer.dataSourceUpdated()
        }) {[weak self] in
            self?.observer.dataSourceFailed()
        }
    }
    
    func loadPreviousPage() {
        DataManager.sharedInstance.getPreviousPageEntries(success: {[weak self] (posts) in
            self?.posts = posts
            
            self?.observer.dataSourceUpdated()
        }) {[weak self] in
            self?.observer.dataSourceFailed()
        }
    }
    
}

extension PostsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell : RedditPostTableViewCell = tableView.dequeueReusableCell(withIdentifier: RedditPostTableViewCell.identifier) as? RedditPostTableViewCell else {
            return UITableViewCell()
        }
        
        postCell.setupCell(post: posts[indexPath.row])
        
        return postCell
    }
    
}
