//
//  ProtocolSendWeatherData.swift
//  WorldWeather
//
//  Created by Jinzhou Yan on 4/10/22.
//

import Foundation

protocol SendWeatherDelegate {
    func sendWeatherData(currentWeatherModel: CurrentWeatherModel)
}
