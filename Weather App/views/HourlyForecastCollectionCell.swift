//
//  HourlyForecastCollectionCell.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/12/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import UIKit

class HourlyForecastCollectionCell: UICollectionViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    func generateHourlyCollectionCell(weather : HourelyForecast) {
        
        self.time.text = weather.date.getTime()
        self.weatherIcon.image = getweatherIconFor(weather.weatherIcon)
        self.temprature.text = String(format: "%.0f", weather.temp) + "°c"
    }

}
