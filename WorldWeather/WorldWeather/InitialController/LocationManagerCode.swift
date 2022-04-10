//
//  LocationManagerCode.swift
//  WorldWeather
//
//  Created by Jinzhou Yan on 4/10/22.
//

import Foundation
import CoreLocation

extension ViewController : CLLocationManagerDelegate {//get data function
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){//6.locationManager获取经纬:didUpdateLocations
        guard let location = locations.last else { return }
        
        let lat = location.coordinate.latitude
        let lng = location.coordinate.longitude
        
        print(lat)
        print(lng)
        
        let url =  locationAPIURL
        getLocationData(url)
        .done { location in
            print(location.key)
            print(location.city)
            print(location.state)
            print(location.country)
            
            self.getCurrentWeather(currentWeatherURL).done{ CurrentWeatherModel in
                print(CurrentWeatherModel.WeatherText)
                print(CurrentWeatherModel.WeatherIcon)
                print(CurrentWeatherModel.IsDayTime)
                print(CurrentWeatherModel.Temperature)
            }
            .catch { error in
                print(error.localizedDescription)
            }
        }
        .catch { error in
            print(error.localizedDescription)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){//6. locationManager的catch:didFailWithError
        print("Error in getting location \(error.localizedDescription)")
    }
    
    
}
