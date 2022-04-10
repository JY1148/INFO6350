//
//  SecondViewController.swift
//  ProtocolAssignment
//
//  Created by Jinzhou Yan on 2/18/22.
//

import UIKit

protocol SendFirstAndLastNameDelegate {
    func setFirstAndLastName(firstName: String, lastName: String)
    func setWelcomeText(welcomeText: String)
}
class SecondViewController: UIViewController {
    var firstname : String?
    var lastname : String?
    var sendFirstAndLastNameDelegate : SendFirstAndLastNameDelegate?
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let firstname = firstname else { return }
        guard let lastname = lastname else { return }
        txtFirstName.text = firstname;
        txtLastName.text = lastname;
        // Do any additional setup after loading the view.
    }
    @IBAction func setNameAction(_ sender: Any) {
        guard let first = txtFirstName.text else {return}
        guard let last = txtLastName.text else {return}
        
        sendFirstAndLastNameDelegate?.setFirstAndLastName(firstName: first, lastName: last)
        sendFirstAndLastNameDelegate?.setWelcomeText(welcomeText: "Welcome!\(first),\(last)")
        self.navigationController?.popViewController(animated: true)
    }

}
