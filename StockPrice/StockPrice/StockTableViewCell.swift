//
//  StockTableViewCell.swift
//  StockPrice
//
//  Created by Jinzhou Yan on 4/10/22.
//

import UIKit

class StockTableViewCell: UITableViewCell {

   
    
    var sendStockDelegate : SendStockDelegate?
    
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    
    var symbol = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func getPriceAction(_ sender: Any) {
        let currentURL = "\(urlQuote)\(symbol)?apikey=\(APIKEY)"
        print(currentURL)
        getStockQuote(currentURL).done { currentStockModel in
            currentStockModel.symbol = self.symbol
            
            print(currentStockModel.company)
            print(currentStockModel.symbol)
            print(currentStockModel.price)
            print(currentStockModel.daylow)
            print(currentStockModel.dayhigh)
            self.sendStockDelegate?.SendStockData(currentStockModel)
        }
        .catch { error in
            print(error.localizedDescription)
        }
    }
    
}
