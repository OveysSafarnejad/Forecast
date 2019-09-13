//
//  HourlyForecast.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/9/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON




class HourelyForecast {
    
    private var _date: Date!
    private var _temp: Double!
    private var _weatherIcon: String!
    
    
    var date: Date {
        if _date == nil {
            _date = Date()
        }
        return _date
    }
    
    
    var temp: Double {
        if _temp == nil {
            _temp = 0.0
        }
        return _temp
    }
    
    
    var weatherIcon: String {
        if _weatherIcon == nil {
            _weatherIcon = ""
        }
        return _weatherIcon
    }
    
    init() {
        
    }
    
    init(weatherDict : Dictionary< String , AnyObject>) {
        
        let json = JSON(weatherDict)
        self._temp = json["temp"].double
        self._date = currentDateFromUnixFormat(unixValue: json["ts"].double)
        self._weatherIcon = json["weather"]["icon"].stringValue
    }
    
    class func getHourlyWeather(location: WeatherLocation, completion: @escaping(_ hourlyForecast : [HourelyForecast]) -> Void) {
        
        var URL : String!
        
        
        if !location.isCurrentLocation {
            URL = String(format: "https://api.weatherbit.io/v2.0/forecast/hourly?city=%@,%@&hours=24&key=d60e1271152e480cba3794c5c6039f58", location.city , location.countryCode)
        } else {
            URL = LOCATION_HOURLYFORECAST_URL
        }
        
        Alamofire.request(URL).responseJSON { (response) in
            let result = response.result
            
            var forecasts : [HourelyForecast] = []
            if result.isSuccess {
            
                
                if let dictionary = result.value as? Dictionary<String , AnyObject> {
                    if let list = dictionary["data"] as? [Dictionary<String , AnyObject>] {
                        for item in list{
                            let singleHour = HourelyForecast(weatherDict: item)
                            forecasts.append(singleHour)
                        }
                    }
                }
                completion(forecasts)
                
            } else {
                
                completion(forecasts)
                print("there is no result,sth. went wrong!")
            }
        }
        
    }
    
}
