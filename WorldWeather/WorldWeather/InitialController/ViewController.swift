//
//  ViewController.swift
//  WorldWeather
//
//  Created by Jinzhou Yan on 4/3/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    let cities = ["Current Location", "Seattle", "Portland", "London", "Delhi", "Shanghai"]
    
    var citiesModel: [CurrentWeatherModel]?
    
    @IBOutlet weak var UISearchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    let locationManager = CLLocationManager()//4.调用CLLocationManager
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        citiesModel = initializeCities()
        
    }
    @IBAction func getLocation(_ sender: Any) {
        locationManager.requestLocation()//button onclick
    }
    
    func initializeCities() -> [CurrentWeatherModel]{
        let currentlocation = CurrentWeatherModel("Seattle","2628285");
        let seattle = CurrentWeatherModel("Seattle","2628285");
        let portland = CurrentWeatherModel("Portland","2627656");
        let london = CurrentWeatherModel("London","2532799");
        let delhi = CurrentWeatherModel("Delhi","3588318");
        let shanghai = CurrentWeatherModel("Shanghai","74833");
        
        var modelArr = [CurrentWeatherModel]()
        
        modelArr.append(currentlocation)
        modelArr.append(seattle)
        modelArr.append(portland)
        modelArr.append(london)
        modelArr.append(delhi)
        modelArr.append(shanghai)
        
        return modelArr
    }
    
    
}

