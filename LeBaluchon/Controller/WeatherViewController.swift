//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var newYorkNameLabel: UILabel!
    @IBOutlet weak var newYorkTemperatureLabel: UILabel!
    @IBOutlet weak var newYorkDescriptionLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var longitude = 0.00
    var latitude = 0.00
    var coords = ""
    var newYorkCoords = "&lon=\(-74.005941)&lat=\(40.712784)"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        WeatherAPIHelper.shared.performRequest(coords: newYorkCoords,  completion: { _, weatherValue in
            DispatchQueue.main.async {
                
                let temperature = weatherValue?.temperature ?? 0
                self.newYorkTemperatureLabel.text = weatherValue?.displayTemperature(temperature: temperature)
                self.newYorkDescriptionLabel.text = weatherValue?.description
                self.newYorkNameLabel.text = weatherValue?.city
                
            }
        })
    }
}

// Use CLLocationManagerDelegate to retrieve their coordinate to use the API call of WeatherAPIHelper
extension WeatherViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            coords = "&lon=\(longitude)&lat=\(latitude)"
            
            WeatherAPIHelper.shared.performRequest(coords: coords,  completion: { _, weatherValue in
                DispatchQueue.main.async {
                    let temperature = weatherValue?.temperature ?? 0
                    self.temperatureLabel.text = weatherValue?.displayTemperature(temperature: temperature)
                    self.descriptionLabel.text = weatherValue?.description
                    self.cityNameLabel.text = weatherValue?.city
                    
                }
            })
            
        }
    }
    
    // Manage error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
