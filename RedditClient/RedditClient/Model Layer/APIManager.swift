//
//  APIManager.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

class APIManager: NSObject {

    static let sharedInstance = APIManager()
    
    let baseUrl : String = "http://api.reddit.com/"
    
    func getTopPosts(parameters: [String: AnyObject],
                       success: @escaping (_ posts:[RedditPost], _ before: String?, _ after: String?)->(),
                       failure: @escaping ()->()) {
        
        let relativeUrl = URL(string: self.baseUrl + "top?" + parameters.stringFromHttpParameters())!
        let urlRequest : NSMutableURLRequest = NSMutableURLRequest(url: relativeUrl)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            guard error == nil else {
                failure()
                
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                let dataChildren : NSDictionary = json.object(forKey: "data") as! NSDictionary
                let posts : [NSDictionary] = dataChildren.object(forKey: "children") as! [NSDictionary]
                var redditPosts : [RedditPost] = []
                for post in posts {
                    let postData = post.object(forKey: "data") as! NSDictionary
                    redditPosts.append(RedditPost(dictionary: postData))
                }
                success(redditPosts,
                        dataChildren.object(forKey: "before") as? String,
                        dataChildren.object(forKey: "after") as? String)
            } catch {
                failure()
                
                print(error)
            }
        }
        
        task.resume()
    }
    
}
