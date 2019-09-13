//
//  GlobalUtility.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/9/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import Foundation
import UIKit

func currentDateFromUnixFormat(unixValue: Double?) -> Date {
    
    if unixValue != nil {
        return Date(timeIntervalSince1970: unixValue!)
    } else {
        return Date()
    }
}

func getweatherIconFor(_ weather: String) -> UIImage {
    return UIImage(named: weather)!
}



