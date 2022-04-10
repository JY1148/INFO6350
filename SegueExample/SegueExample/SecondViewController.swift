//
//  SecondViewController.swift
//  SegueExample
//
//  Created by Jinzhou Yan on 2/8/22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblWelcome: UILabel!
    var welcomeStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblWelcome.text = welcomeStr
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
