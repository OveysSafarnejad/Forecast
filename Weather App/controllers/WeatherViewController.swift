//
//  WeatherViewController.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/10/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var weatherView: WeatherView!
    
    var location : WeatherLocation!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.view.frame.size
        gradientLayer.colors =
            [UIColor(red: 15.0/255.0, green: 31.0/255.0, blue: 82.0/255.0, alpha: 0.9).cgColor,
             UIColor(red: 133.0/255.0, green: 94.0/255.0, blue: 156.0/255.0, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.zPosition = -1
        self.view.layer.addSublayer(gradientLayer)
        
        //        let weatherView = WeatherView()
        //        weatherView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        location = WeatherLocation(city: "Shiraz", country: "Iran", countryCode: "IR", isCurrentLocation: false)
        //Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        self.getCurrentWeatherInfo(weatherView: weatherView)
        self.getHourlyWeatherInfo(weatherView: weatherView)
        self.getDailyWeatherInfo(weatherView: weatherView)
        //        scrollView.addSubview(weatherView)
        
    }
    
    
    //MARK: find data
    
    private func getCurrentWeatherInfo(weatherView: WeatherView) {
        weatherView.current = CurrentWeatherState()
        weatherView.current.getCurrentWeatherState(location: location) { (success) in
            DispatchQueue.main.async {
                weatherView.refresh()
            }
        }
    }
    
    
    private func getDailyWeatherInfo(weatherView: WeatherView) {
        
        DailyForecast.getDailyWeather(location: location) { (dailyForecast) in
            weatherView.dailyWeatherData = dailyForecast
            DispatchQueue.main.async {
                weatherView.daysTable.reloadData()
            }
        }
    }
    
    
    private func getHourlyWeatherInfo(weatherView: WeatherView) {
        
        
        HourelyForecast.getHourlyWeather(location: location) { (hourlyForecast) in
            
            weatherView.hourlyWeatherData = hourlyForecast
            DispatchQueue.main.async {
                weatherView.hoursCollection.reloadData()
            }
        }
    }
    
}
