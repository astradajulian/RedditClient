//
//  Date+Utils.swift
//  RedditClient
//
//  Created by Julian Astrada on 21/07/2019.
//  Copyright © 2019 Julian Astrada. All rights reserved.
//

import UIKit

// MARK : - Date extention

extension Date {
    
    func formattedStringAge() -> String {
        let postingAgeDateComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: self, to: Date())
        
        if let day = postingAgeDateComponents.day, day > 0 {
            guard day != 1 else {
                return NSLocalizedString("1 day ago", comment: "1 day ago")
            }
                
            let formatted = NSLocalizedString("%d days ago", comment: "Days ago")
            
            return String(format: formatted, day)
        }
        
        if let hour = postingAgeDateComponents.hour, hour > 0 {
            guard hour != 1 else {
                return NSLocalizedString("1 hour ago", comment: "1 hour ago")
            }
            
            let formatted = NSLocalizedString("%d hours ago", comment: "Hours ago")
            
            return String(format: formatted, hour)
        }
        
        if let minute = postingAgeDateComponents.minute, minute > 0 {
            guard minute != 1 else {
                return NSLocalizedString("1 minute ago", comment: "1 minute ago")
            }
            
            let formatted = NSLocalizedString("%d minutes ago", comment: "minutes ago")
            
            return String(format: formatted, minute)
        }
        
        if let second = postingAgeDateComponents.second, second > 0 {
            guard second != 1 else {
                return NSLocalizedString("1 second ago", comment: "1 second ago")
            }
            
            let formatted = NSLocalizedString("%d seconds ago", comment: "Seconds ago")
            
            return String(format: formatted, second)
        }
        
        return NSLocalizedString("Just now", comment: "Just now")
    }
    
}
