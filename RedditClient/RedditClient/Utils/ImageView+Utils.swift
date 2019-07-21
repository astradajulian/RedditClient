//
//  ImageView+Utils.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImageFromURL(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async() {[weak self] () -> Void in
                if error != nil {
                    self?.image = UIImage(named: "placeholder")
                } else {
                    self?.image = UIImage(data: data!)
                }
            }
        }.resume()
    }
    
}
