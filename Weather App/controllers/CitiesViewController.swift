//
//  CitiesViewController.swift
//  Weather App
//
//  Created by Oveys Safarnejad on 9/14/19.
//  Copyright © 2019 Borna. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var citiesTable: UITableView!
    
    var allLocations:[WeatherLocation] = []
    var filteredLocation : [WeatherLocation] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
        
        
        
        setupSearchController()
        citiesTable.tableHeaderView = searchController.searchBar
        citiesTable.tableFooterView = UIView()
        loadLocationsFromCSV()
    }
    
    private func loadLocationsFromCSV() {
        if let path = Bundle.main.path(forResource: "location", ofType: "csv") {
            loadFromCSVAt(at: URL(fileURLWithPath: path))
        }
    }
    
    private func setupSearchController() {
        
        
        searchController.searchBar.backgroundColor = .clear
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "City Or Country..."
        //        searchController.searchResultsUpdater = self
        
        definesPresentationContext = true
        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchController.searchBar.sizeToFit()
        
    }
    
    private func loadFromCSVAt(at : URL) {
        
        do {
            let data = try Data(contentsOf: at)
            let encodedData = String(bytes: data, encoding: .utf8)
            if let dataArr = encodedData?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                
                var i = 0
                for line in dataArr {
                    if line.count > 2 && i != 0 {
                        createLocationFromData(line: line)
                    }
                    i += 1
                }
            }
            
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    
    private func createLocationFromData(line: [String]) {
        
        allLocations.append(WeatherLocation(city: line[0], country: line[1], countryCode: line[2], isCurrentLocation: false))
    }
    
}



extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectingCityCell", for: indexPath)
        
        let location = filteredLocation[indexPath.row]
        cell.textLabel?.text = location.city
        cell.detailTextLabel?.text = location.country
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //saveToUserDefaults(location: filteredLocations[indexPath.row])
        //delegate?.didAdd(newLocation: filteredLocations[indexPath.row])
        
        //dismissView()
    }
    
}
