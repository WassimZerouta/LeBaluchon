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
    
    
    let locationManager = CLLocationManager()
    var longitude = 0.00
    var latitude = 0.00
    var coords = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            coords = "&lon=\(longitude)&lat=\(latitude)"
            
            WeatherAPIHelper.shared.performRequest(coords: coords,  completion: { _, weatherValue in
                DispatchQueue.main.async {
                    self.temperatureLabel.text = String(weatherValue!.temperature)
                    self.descriptionLabel.text = weatherValue!.description
                    self.cityNameLabel.text = weatherValue?.city
                    
                }
            }
        )}
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
