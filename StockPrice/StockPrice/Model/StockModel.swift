//
//  StockModel.swift
//  StockPrice
//
//  Created by Jinzhou Yan on 4/10/22.
//

import Foundation

class StockModel {
    init(_ symbol : String, _ company : String){
        self.symbol = symbol
        self.company = company
    }
    var company : String = ""
    var symbol : String = ""
    var price : Float = 0.0
    var dayhigh : Float = 0.0
    var daylow : Float = 0.0
}
