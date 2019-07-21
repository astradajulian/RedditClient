//
//  RedditPostTableViewCell.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

class RedditPostTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    static let identifier = "RedditPostTableViewCell"
    
    func setupCell(post: RedditPost) {
        self.authorLabel.text = post.author
        
        self.titleLabel.text = post.title
        
        self.commentsLabel.text = "\(post.numberOfComments) comments"
        
        self.ageLabel.text = post.date.formattedStringAge()
        
        if let thumbnailURL = post.thumbnail {
            self.thumbnailImageView.setImageFromURL(url: thumbnailURL)
        }
        
        self.thumbnailImageView.isHidden = post.thumbnail == nil
    }
    
}
