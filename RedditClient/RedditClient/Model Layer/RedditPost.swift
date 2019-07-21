//
//  RedditPost.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

class RedditPost: NSObject {

    var title : String
    var author : String
    var date : Date
    var thumbnail : URL?
    var imageUrl : URL?
    var numberOfComments : Int
    
    init(dictionary : NSDictionary) {
        self.title = dictionary.object(forKey: "title") as? String ?? ""
        
        self.author = dictionary.object(forKey: "author") as? String ?? ""
        
        self.date = Date(timeIntervalSince1970: dictionary.object(forKey: "created_utc") as? TimeInterval ?? Date.timeIntervalSinceReferenceDate)
        
        if let thumbnailURL = dictionary.object(forKey: "thumbnail") as? String, !thumbnailURL.isEmpty {
            self.thumbnail = URL(string: thumbnailURL)
        }
        
        self.numberOfComments = dictionary.object(forKey: "num_comments") as? Int ?? 0
    }
    
}
