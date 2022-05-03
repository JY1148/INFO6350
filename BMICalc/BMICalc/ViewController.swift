//
//  ViewController.swift
//  BMICalc
//
//  Created by Jinzhou Yan on 5/2/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblBMI: UILabel!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtHeightFeet: UITextField!
    @IBOutlet weak var txtHeightInches: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calcBMIAction(_ sender: Any) {
        let weight = (txtWeight.text! as  NSString ).doubleValue
        let heightFeet = (txtHeightFeet.text! as  NSString ).doubleValue
        let heightInches = (txtHeightInches.text! as  NSString ).doubleValue
        let kilogram = weight/2.205
        let heightInchesSum = 12*heightFeet + heightInches
        let meter = heightInchesSum/39.37
        
        let BMI = Double(kilogram/(meter*meter))
        lblBMI.text = String(BMI)
    }
    
}

