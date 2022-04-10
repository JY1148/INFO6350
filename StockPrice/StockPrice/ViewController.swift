//
//  ViewController.swift
//  StockPrice
//
//  Created by Jinzhou Yan on 4/10/22.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SendStockDelegate {
    
    
    
    //FB, AAPL, GOOG, MSFT, AMZN
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDayHigh: UILabel!
    @IBOutlet weak var lblDayLow: UILabel!
    let stock = ["FB", "AAPL", "GOOG", "MSFT", "AMZN"]
    
    var stockModel : [StockModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        stockModel = initializeStock()
        getApple()
    }
    
    func getApple(){
        let aaplURL = "https://financialmodelingprep.com/api/v3/quote/AAPL?apikey=\(APIKEY)"
    
        getStockQuote(aaplURL).done { currentStockModel in
            self.lblPrice.text = "$\(currentStockModel.price) "
            self.lblCompany.text = "\(currentStockModel.company) "
            self.lblSymbol.text = "\(currentStockModel.symbol) "
            self.lblDayHigh.text = "\(currentStockModel.dayhigh) "
            self.lblDayLow.text = "\(currentStockModel.daylow) "
        }
        .catch { error in
            print(error.localizedDescription)
        }
        
    }
   
    func initializeStock() -> [StockModel]{
        
        let faceboook = StockModel("FB","Meta Platforms,Inc.");
        let apple = StockModel("AAPL","Apple.com, Inc");
        let google = StockModel("GOOG","Alphabet Inc.");
        let microsoft = StockModel("MSFT","Microsoft Corporation");
        let amazon = StockModel("AMZN", "Amazon.com, Inc");
                                
        var modelArr = [StockModel]()
        
        modelArr.append(faceboook)
        modelArr.append(apple)
        modelArr.append(google)
        modelArr.append(microsoft)
        modelArr.append(amazon)
        
       return modelArr
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = stockModel?.count else {return 0}
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("StockTableViewCell", owner: self, options: nil)?.first as! StockTableViewCell
        
        guard let stockModel = stockModel?[indexPath.row] else {
            return cell
        }
        
        cell.lblSymbol.text = stockModel.symbol
        cell.lblCompany.text = stockModel.company
        cell.symbol = stockModel.symbol
        cell.sendStockDelegate = self
        return cell
    }
    
    func SendStockData(_ currentStockModel: StockModel) {
        lblCompany.text = currentStockModel.company
        lblSymbol.text = currentStockModel.symbol
        lblPrice.text = "$\(currentStockModel.price)"
        lblDayHigh.text = "$\(currentStockModel.dayhigh)"
        lblDayLow.text = "$\(currentStockModel.daylow)"
    }
}

