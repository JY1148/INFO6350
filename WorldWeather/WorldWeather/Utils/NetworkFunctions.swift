//
//  NetworkFunctions.swift
//  WorldWeather
//
//  Created by Jinzhou Yan on 4/10/22.
//

import Foundation

func getLocationURL(_ lat : String, _ lng : String)-> String {
    let url = "\(locationAPIURL)\(APIKEY)&q=\(lat),\(lng)"
    return url
}

func getCurrentWeatherURL(_ cityKey : String) -> String{
    let url = "\(currentWeatherURL)\(cityKey)?apikey\(APIKEY)"
    return url
}
