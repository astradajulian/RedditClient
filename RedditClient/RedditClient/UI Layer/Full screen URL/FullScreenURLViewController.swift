//
//  PostDetailViewController.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit
import WebKit

class FullScreenURLViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var post: RedditPost!
    
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        
        self.webView.navigationDelegate = self
        
        if let url = post.imageUrl {
            if url.relativePath.contains(".jpg") || url.relativePath.contains(".png") {
                do {
                    self.saveButton.isEnabled = true
                    let data = try Data(contentsOf: url)
                    self.imageData = data
                    self.webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url)
                } catch {
                    print(error)
                }
            } else {
                self.saveButton.isEnabled = false
                self.webView.load(URLRequest(url: url))
            }
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let data = self.imageData else {
            return
        }
        
        let compressedJPGImage = UIImage(data: data)
        
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "The image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}

// MARK : - WKNavigationDelegate

extension FullScreenURLViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
    }
    
}
