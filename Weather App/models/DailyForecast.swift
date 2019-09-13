//
//  DailyForecast.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/9/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON


class DailyForecast {
    
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
    
    class func getDailyWeather(location: WeatherLocation, completion: @escaping(_ dailyForecast : [DailyForecast]) -> Void) {
        
        
        var URL : String!
        
        
        if !location.isCurrentLocation {
            URL = String(format: "https://api.weatherbit.io/v2.0/forecast/daily?city=%@,%@&days=7&key=d60e1271152e480cba3794c5c6039f58", location.city , location.countryCode)
        } else {
            URL = LOCATION_DAILYFORECAST_URL
        }
        
        Alamofire.request(URL).responseJSON { (response) in
            let result = response.result
            
            var forecasts : [DailyForecast] = []
            if result.isSuccess {
                
                if let dictionary = result.value as? Dictionary<String , AnyObject> {
                    if var list = dictionary["data"] as? [Dictionary<String , AnyObject>] {
                        list.remove(at: 0)
                        for item in list {
                            let forecast = DailyForecast(weatherDict: item)
                            forecasts.append(forecast)
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
