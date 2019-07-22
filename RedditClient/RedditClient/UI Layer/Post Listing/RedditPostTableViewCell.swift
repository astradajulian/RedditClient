//
//  RedditPostTableViewCell.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

protocol RedditPostCellDelegate {
    func thumbnailPressed(cell: RedditPostTableViewCell)
    
    func dismissed(cell: RedditPostTableViewCell)
}

class RedditPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var unseenIndicator: UIView! {
        didSet {
            self.unseenIndicator.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    static let identifier = "RedditPostTableViewCell"
    
    var delegate: RedditPostCellDelegate?
    
    func setupCell(post: RedditPost) {
        self.authorLabel.text = post.author
        
        self.titleLabel.text = post.title
        
        self.commentsLabel.text = "\(post.numberOfComments) comments"
        
        self.ageLabel.text = post.date.formattedStringAge()
        
        if let thumbnailURL = post.thumbnail {
            self.thumbnailImageView.setImageFromURL(url: thumbnailURL)
        }
        
        self.thumbnailImageView.isHidden = post.thumbnail == nil
        
        self.unseenIndicator.isHidden = !post.unseen
        
        let thumbnailTap = UITapGestureRecognizer(target: self, action: #selector(thumbnaiPressed))
        self.thumbnailImageView.addGestureRecognizer(thumbnailTap)
    }
    
    @objc func thumbnaiPressed(_ sender: Any) {
        self.delegate?.thumbnailPressed(cell: self)
    }
    
    @IBAction func dissmissButtonPressed(_ sender: Any) {
        self.delegate?.dismissed(cell: self)
    }
}
