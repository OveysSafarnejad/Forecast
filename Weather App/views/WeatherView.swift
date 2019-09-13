//
//  WeatherView.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/11/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttomContainer: UIView!
    @IBOutlet weak var hoursCollection: UICollectionView!
    @IBOutlet weak var infoCollection: UICollectionView!
    @IBOutlet weak var daysTable: UITableView!
    
    
    
    
    
    
    //MARK: - vars
    
    var current: CurrentWeatherState!
    
    var dailyWeatherData: [DailyForecast] = []
    var hourlyWeatherData: [HourelyForecast] = []
    var weatherInfoData: [weatherInfo] = []
    
    //MARK: build by data
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mainInit()
    }
    
    
    private func mainInit(){
        
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight , .flexibleWidth]
        setupDaysTable()
        setuphourlyCollection()
        setupInfoCollection()
    }
    
    
    private func setupDaysTable() {
        
        daysTable.showsVerticalScrollIndicator = false
        daysTable.separatorStyle = .none
        daysTable.register(UINib(nibName: "DaysCell", bundle: Bundle.main), forCellReuseIdentifier: "DaysCell")
        daysTable.delegate = self
        daysTable.dataSource = self
        daysTable.tableFooterView = UIView()
    }
    
    
    private func setuphourlyCollection() {
        
        self.hoursCollection.register(UINib(nibName: "HourlyForecastCollectionCell", bundle: Bundle.main ), forCellWithReuseIdentifier: "HourlyForecastCollectionCell")
        self.hoursCollection.showsHorizontalScrollIndicator = false
        self.hoursCollection.dataSource = self
    }
    
    
    
    private func setupInfoCollection() {
        
        self.infoCollection.register(UINib(nibName: "InfoCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "WeatherInfoCell")
        self.infoCollection.dataSource = self
    }
    
    func refresh() {
        self.status.minimumScaleFactor = 8/15
        self.status.adjustsFontSizeToFitWidth = true
        setCurrentWeather()
        setWeatherInfo()
        self.infoCollection.reloadData()
    }
    
    private func setCurrentWeather() {
        
        self.city.text = self.current.city
        self.date.text = self.current.date.shortFormat()
        self.humidity.text = String(format: "%.0f", self.current.humidity)+" %"
        self.windSpeed.text = String(self.current.windSpeed)+" m/s"
        self.temprature.text = String( format: "%.0f", self.current.currentTemp)
        self.status.text = self.current.weatherType
        
    }
    
    private func setWeatherInfo(){
        
        let visibility = weatherInfo(infoText: "\(current.visibility)", uvText: nil, image: getweatherIconFor("visibility"))
        let wind = weatherInfo(infoText: "\(current.windSpeed) m/s", uvText: nil, image: getweatherIconFor("wind"))
        let humidity = weatherInfo(infoText: "\(current.humidity) %", uvText: nil, image: getweatherIconFor("humidity"))
        let feelsLike = weatherInfo(infoText: "\(current.feelsLike) °c", uvText: nil, image: getweatherIconFor("feelsLike"))
        let uv = weatherInfo(infoText: "\(current.uv)", uvText: "UV", image: nil)
        let sunrise = weatherInfo(infoText: "\(current.sunrise) am", uvText: nil, image: getweatherIconFor("sunrise"))
        let sunset = weatherInfo(infoText: "\(current.sunset) pm", uvText: nil, image: getweatherIconFor("sunset"))
        
        weatherInfoData = [sunrise , sunset , feelsLike , visibility , humidity , wind ,  uv]
        
    }
    
}


extension WeatherView : UITableViewDataSource ,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DaysCell", for: indexPath) as! DaysCell
        cell.generateTableCell(daily: dailyWeatherData[indexPath.row])
        return cell
    }
    
    
}



extension WeatherView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == hoursCollection {
            
            return hourlyWeatherData.count
        } else {
            return weatherInfoData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == hoursCollection {
            
            let cell = hoursCollection.dequeueReusableCell(withReuseIdentifier: "HourlyForecastCollectionCell", for: indexPath) as! HourlyForecastCollectionCell
            cell.generateHourlyCollectionCell(weather: hourlyWeatherData[indexPath.row])
            return cell
            
            
        } else {
            
            
            let cell = infoCollection.dequeueReusableCell(withReuseIdentifier: "WeatherInfoCell", for: indexPath) as! InfoCollectionCell
            cell.generateInfoCell(info: weatherInfoData[indexPath.row])
            return cell
            
        }
        
        
    }
    
    
}


