//
//  Extensions.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/12/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import Foundation


extension Date {
    
     func shortFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: self)
    }
    
    
    func getTime() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func getDayOfWeek() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
