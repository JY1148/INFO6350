//
//  ViewController.swift
//  SearchBarExample
//
//  Created by Jinzhou Yan on 3/6/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    var namesArray = ["Ashish", "Ashley", "Amanda", "Mark", "Mike", "Mary", "Marissa"]
    var searchArray = ["Ashish", "Ashley", "Amanda", "Mark", "Mike", "Mary", "Marissa"]

    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = namesArray[indexPath.row]
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchBar.text! // search key word
        
        
        guard !text.isEmpty else{ //same as the if chunk below
            namesArray = searchArray //searchArray didnt change
            tblView.reloadData() //render: reload table view
            return
        }
        
        namesArray = searchArray.filter({ name in
            name.lowercased().contains(searchBar.text!.lowercased())// contains search bar's text
        })
        
        tblView.reloadData()//render: reload table view
    }
}

