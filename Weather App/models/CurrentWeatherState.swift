//
//  CurrentLocationState.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/9/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentWeatherState {
    
    private var _city: String!
    private var _date: Date!
    private var _currentTemp: Double!
    private var _feelsLike: Double!
    private var _uv: Double!
    
    
    var city : String {
        if _city == nil {
            _city = ""
        }
        return _city
    }
    
    
    var date : Date {
        if _date == nil {
            _date = Date()
        }
        return _date
    }
    
    var currentTemp : Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    
    var feelsLike : Double {
        if _feelsLike == nil {
            _feelsLike = 0.0
        }
        return _feelsLike
    }
    
    var uv : Double {
        if _uv == nil {
            _uv = 0.0
        }
        return _uv
    }
    
    
    private var _weatherType: String!
    private var _sunrise: String!
    private var _sunset: String!
    private var _weatherIcon: String!
    private var _humidity : Double!
    private var _windSpeed: Double!
    private var _visibility: Double!
    
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    
    var sunrise : String {
        if _sunrise == nil {
            _sunrise = ""
        }
        return _sunrise
    }
    
    
    var sunset : String {
        if _sunset == nil {
            _sunset = ""
        }
        return _sunset
    }
    
    
    var weatherIcon : String {
        if _weatherIcon == nil {
            _weatherIcon = ""
        }
        return _weatherIcon
    }
    
    
    var humidity : Double {
        if _humidity == nil {
            _humidity = 0.0
        }
        return _humidity
    }
    
    
    var windSpeed : Double {
        if _windSpeed == nil {
            _windSpeed = 0.0
        }
        return _windSpeed
    }
    
    
    var visibility : Double {
        if _visibility == nil {
            _visibility = 0.0
        }
        return _visibility
    }
    
    
    
    
    
    
    func getCurrentWeatherState(completion : @escaping (_ success :Bool)-> Void){
        let URL = "https://api.weatherbit.io/v2.0/current?city=Rasht,IR&key=d60e1271152e480cba3794c5c6039f58"
        
        Alamofire.request(URL).responseJSON { (response) in
            let result = response.result
            if result.isSuccess {
                let json = JSON(result.value as Any)
                self.mapToObject(json: json)
                completion(true)
                
            } else {
                completion(false)
                print("there is no result,sth. went wrong!")
            }
        }
    }
    
    
    func mapToObject(json:JSON) {
        
        self._city = json["data"][0]["city_name"].stringValue
        self._date = currentDateFromUnixFormat(unixValue: json["data"][0]["ts"].double)
        self._currentTemp = json["data"][0]["temp"].double
        self._feelsLike = json["data"][0]["app_temp"].double
        self._uv = json["data"][0]["uv"].double
        
        self._weatherType = json["data"][0]["weather"]["description"].stringValue
        self._sunrise = json["data"][0]["sunrise"].stringValue
        self._sunset = json["data"][0]["sunset"].stringValue
        self._weatherIcon = json["data"][0]["weather"]["icon"].stringValue
        self._windSpeed = json["data"][0]["wind_spd"].double
        self._humidity = json["data"][0]["rh"].double
        self._visibility = json["data"][0]["vis"].double

    }
}
