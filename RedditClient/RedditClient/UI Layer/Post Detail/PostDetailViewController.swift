//
//  PostDetailViewController.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit
import WebKit

class PostDetailViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    
    var post: RedditPost!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        
        self.webView.navigationDelegate = self
        
        if let url = post.imageUrl {
            if url.relativePath.contains(".jpg") || url.relativePath.contains(".png") {
                do {
                    let data = try Data(contentsOf: url)
                    self.webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url)
                } catch {
                    print(error)
                }
            } else {
                self.webView.load(URLRequest(url: url))
            }
        }
    }
}

extension PostDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
    }
    
}
