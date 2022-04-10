//
//  ViewController.swift
//  PromisesExample
//
//  Created by Jinzhou Yan on 3/6/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit

class ViewController: UIViewController {
    let urlShortQuote = "https://financialmodelingprep.com/api/v3/quote-short/FB?apikey="
    let APIKEY = "095d6447ebdade488239e2d533914820"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getDataAction(_ sender: Any) {
        
        let url = urlShortQuote + APIKEY
        getStockData(url)
            .done { quote in
                print(quote.price)
                print(quote.volume)
                print(quote.symbol)
            }
            .catch { error in
                print(error.localizedDescription)
            }
        
    }
    
    func getStockData(_ url: String)-> Promise<QuoteShort>{
        //return a promise of QuoteShort
        return Promise<QuoteShort> { seal -> Void in
            //seal means agreement
            AF.request(url).responseJSON{ response in
                
                //if error, reject promise
                if response.error != nil{
                    seal.reject(response.error!)
                }
                
                //otherwise, get data, fulfill the promise
                let stocks = JSON(response.data!).array
                guard let stock = stocks!.first else { return }
                let quote = QuoteShort()
                quote.symbol = stock["symbol"].stringValue
                quote.price = stock["price"].floatValue
                quote.volume = stock["volume"].intValue
                seal.fulfill(quote)
            }
        }
    }
}

