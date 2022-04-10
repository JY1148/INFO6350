//
//  TableViewCode.swift
//  WorldWeather
//
//  Created by Jinzhou Yan on 4/3/22.
//
import UIKit
import Foundation

extension ViewController: UITableViewDelegate, UITableViewDataSource {//display table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let rows = citiesModel?.count else {return 0}
        return rows
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row == 0{
            cell.textLabel?.text = "Current Location"
        }else{
            cell.textLabel?.text = citiesModel![indexPath.row - 1].city
        }
        
        
        return cell
    }
    
}
