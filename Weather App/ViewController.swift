//
//  ViewController.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/8/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hourly = DailyForecast()
        hourly.getDailyWeather(completion: { (forecasts) in
            for forecast in forecasts {
                print("data is \(forecast.date),\(forecast.temp),\(forecast.weatherIcon)")
            }
            
        })
    }


}

