//
//  NetworkingFile.swift
//  StockPrice
//
//  Created by Jinzhou Yan on 4/10/22.
//

import Foundation
import SwiftyJSON
import Alamofire
import SwiftSpinner
import PromiseKit

func getStockQuote(_ url : String) -> Promise<StockModel>{
    
    return Promise<StockModel> { seal -> Void in
        AF.request(url).responseJSON { response in
            
            if response.error != nil {
                seal.reject(response.error!)
            }
            
            let currentStockModel = StockModel("","")
            // I will get data here
            
            let currentStockArray = JSON(response.data!).arrayValue
            print(currentStockArray)
            guard let currentStock = currentStockArray.first else {return
                seal.fulfill(currentStockModel)
            }
            
            currentStockModel.symbol = currentStock["symbol"].stringValue
            currentStockModel.company = currentStock["name"].stringValue
            currentStockModel.price = currentStock["price"].floatValue
            currentStockModel.dayhigh = currentStock["dayHigh"].floatValue
            currentStockModel.daylow = currentStock["dayLow"].floatValue
            seal.fulfill(currentStockModel) // I am fulfilling the promise
            
            
        }// end of response        }// end is return Promise
    }// end of function
}
