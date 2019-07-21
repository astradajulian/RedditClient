//
//  DataManager.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    
    let DEFAULT_LIMIT = "25"
    
    var count : Int!
    var before : String?
    var after : String?
    
    func getTopEntries(success: @escaping (_ posts:[RedditPost])->(), failure: @escaping ()->()) {
        count = 0
        before = nil
        after = nil
        var param : [String : AnyObject] = [String:AnyObject]()
        param["limit"] = DEFAULT_LIMIT as AnyObject?
        param["count"] = String(count) as AnyObject?
        param["before"] = before as AnyObject?
        param["after"] = after as AnyObject?
        
        APIManager.sharedInstance.getTopPosts(parameters: param, success: {[weak self] (posts, before, after) in
            self?.before = before
            self?.after = after
            success(posts)
        }) {
            failure()
        }
    }
    
    func getNextPageEntries(success: @escaping (_ posts:[RedditPost])->(), failure: @escaping ()->()) {
        count = count + Int(DEFAULT_LIMIT)!
        var param : [String : AnyObject] = [String:AnyObject]()
        param["limit"] = DEFAULT_LIMIT as AnyObject?
        param["count"] = String(count) as AnyObject?
        param["after"] = after as AnyObject?
        
        APIManager.sharedInstance.getTopPosts(parameters: param, success: {[weak self] (posts, before, after) in
            self?.before = before
            self?.after = after
            success(posts)
        }) {
            failure()
        }
    }
    
    func getPreviousPageEntries(success: @escaping (_ posts:[RedditPost])->(), failure: @escaping ()->()) {
        var param : [String : AnyObject] = [String:AnyObject]()
        param["limit"] = DEFAULT_LIMIT as AnyObject?
        param["count"] = String(count) as AnyObject?
        param["before"] = before as AnyObject?
        
        APIManager.sharedInstance.getTopPosts(parameters: param, success: {[weak self] (posts, before, after) in
            self?.before = before
            self?.after = after
            success(posts)
        }) {
            failure()
        }
    }
    
    func isNextPageAvailable() -> Bool {
        return self.after != nil
    }
    
    func isPreviousPageAvailable() -> Bool {
        return self.before != nil
    }
    
}
