//
//  DaysCell.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/12/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import UIKit

class DaysCell: UITableViewCell {
    
    
    @IBOutlet weak var dayOfWeek: UILabel!
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    func generateTableCell(daily : DailyForecast){
        
        self.dayOfWeek.text = daily.date.getDayOfWeek()
        self.temprature.text = String(format: "%.0f", daily.temp) + "°c"
        self.weatherIcon.image = getweatherIconFor(daily.weatherIcon)
        
    }
    
}
