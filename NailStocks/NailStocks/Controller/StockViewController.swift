//
//  StockViewController.swift
//  NailStocks
//
//  Created by Jinzhou Yan on 2/20/22.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire

class StockViewController: UIViewController {

    @IBOutlet weak var txtStockSymbol: UITextField!
    @IBOutlet weak var lblStockPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getStockPrice(_ sender: Any) {
        guard let symbol = txtStockSymbol.text else {return}
        
        let url = "\(shortQuoteURL)\(symbol.uppercased())?apikey=\(APIKeys)"
        
        print(url)
        //"https://financialmodelingprep.com/api/v3/quote-short/FB?apikey=095d6447ebdade488239e2d533914820"

        SwiftSpinner.show("fetching for \(symbol)")
        AF.request(url).responseJSON { response in
            SwiftSpinner.hide(nil)
            if response.error != nil {
                print(response.error!)
                return
            }
            let stocks = JSON(response.data!).array
            guard let stock = stocks!.first else { return }
            
            print(stock)
            //lblStockPrice.text = stocks.volume
            let quote = QuoteShort();
            quote.symbol = stock["symbol"].stringValue
            quote.price = stock["price"].floatValue
            quote.volume = stock["volume"].intValue
            
            self.lblStockPrice.text = "\(quote.symbol) : $\(quote.price) "
        }
    }
            
    
    

}
