//
//  ProtocolSendStockDelegate.swift
//  StockPrice
//
//  Created by Jinzhou Yan on 4/10/22.
//

import Foundation

protocol SendStockDelegate {
    func SendStockData(_ currentStockModel: StockModel)
}
