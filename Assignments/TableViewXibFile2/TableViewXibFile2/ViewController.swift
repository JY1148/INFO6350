//
//  ViewController.swift
//  TableViewXibFile2
//
//  Created by Jinzhou Yan on 2/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let images = ["food1","food2","food3","food4","food5","food6","food7","food8","food9"]
    let imageLabels = ["beef","cake","pasta","pancake","salad","meatball","curry","spirit","ice-cream"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.imgView.image = UIImage(named: images[indexPath.row])
        cell.lblImage.text = imageLabels[indexPath.row]
        return cell
    }
    

}

