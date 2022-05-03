//
//  ViewController.swift
//  BMICalculator
//
//  Created by Jinzhou Yan on 5/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtHeightFeet: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtHeightInches: UITextField!
    @IBOutlet weak var lblBMI: UILabel!
    @IBOutlet weak var lblHealth: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getBMIAction(_ sender: Any) {
        let weight = (txtWeight.text! as NSString).doubleValue
        let heightFeet = (txtHeightFeet.text! as NSString).doubleValue
        let heightInches = (txtHeightInches.text! as NSString).doubleValue
        let heightInchesSum = 12*heightFeet + heightInches
        let BMI = Double(weight/(heightInchesSum*heightInchesSum)*703)
        lblBMI.text = String(BMI)
        if(BMI<18.5){
            lblHealth.text = "Underweight"
        }else if(BMI>=18.5 && BMI<=24.9){
            lblHealth.text = "Healthy weight"
        }else if(BMI>=25 && BMI<=29.9){
            lblHealth.text = "Overweight"
        }else{
            lblHealth.text = "obese"
        }
    }
    
}

