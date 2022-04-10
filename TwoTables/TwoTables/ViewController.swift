//
//  ViewController.swift
//  TwoTables
//
//  Created by Jinzhou Yan on 2/27/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    
    var arr1 = ["Seattle", "NY", "SFQ", "Washington"]
    var arr2 = ["US", "India", "China"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbl1{
            return arr1.count
        } else{
            return arr2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = arr1[indexPath.row]
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            cell.textLabel?.text = arr2[indexPath.row]
            return cell
        }
    }
    

}

