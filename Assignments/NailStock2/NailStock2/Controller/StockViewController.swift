//
//  StockViewController.swift
//  NailStock2
//
//  Created by Jinzhou Yan on 2/25/22.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire

class StockViewController: UIViewController {

    @IBOutlet weak var lblcompany: UILabel!
    @IBOutlet weak var txtsymbol: UITextField!
    @IBOutlet weak var lblprice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getPrice(_ sender: Any) {
        guard let symbol = txtsymbol.text else {return}
        
        let url = "\(quoteURL)\(symbol.uppercased())?apikey=\(APIKeys)"
        
        print(url)
        //"https://financialmodelingprep.com/api/v3/quote/FB?apikey=095d6447ebdade488239e2d533914820"

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
            let quote = Quote();
            quote.symbol = stock["symbol"].stringValue
            quote.price = stock["price"].floatValue
            quote.name = stock["name"].stringValue
            
            self.lblprice.text = "$\(quote.price) "
            self.lblcompany.text = "\(quote.name) "
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
