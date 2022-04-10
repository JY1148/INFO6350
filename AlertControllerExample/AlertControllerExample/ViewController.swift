//
//  ViewController.swift
//  AlertControllerExample
//
//  Created by Jinzhou Yan on 2/27/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTextField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pressMe(_ sender: Any) {
        
        var txtField : UITextField?
        
        let alertController = UIAlertController(title: "Sample Alert Controller", message: "Simple Message", preferredStyle: .alert)
        
        let OKButton = UIAlertAction(title: "OK", style: .default){
            action in print("OK Button pressed")
            self.lblTextField.text = txtField?.text
        }
        
        let cancalButton = UIAlertAction(title:"Canecl", style: .cancel){
            action in print("Cancel Button pressed")
        }
        
        alertController.addAction(OKButton)
        alertController.addAction(cancalButton)
        
        alertController.addTextField{
            lblTextField in
            lblTextField.placeholder = "Type Somthing"
            txtField = lblTextField
            
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

