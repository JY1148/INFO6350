//
//  ViewController.swift
//  HappyOrSadText
//
//  Created by Jinzhou Yan on 4/17/22.
//

import UIKit
import CoreML

class ViewController: UIViewController {

    @IBOutlet weak var txtHappySad: UITextField!
    @IBOutlet weak var lblHappySad: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func analyzeTextAction(_ sender: Any) {
        guard let text = txtHappySad.text else {return}
        
        let model = HappyOrSad_1()
        let prediction = try! model.prediction(text: text).label
        lblHappySad.text = prediction
    }
    
}

