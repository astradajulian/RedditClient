//
//  PostDetailViewController.swift
//  RedditClient
//
//  Created by Julian Astrada on 22/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var post: RedditPost!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.authorLabel.text = post.author
        
        if let thumbnailURL = post.thumbnail {
            self.pictureImageView.setImageFromURL(url: thumbnailURL)
        }
        
        self.titleLabel.text = post.title
    }

}
