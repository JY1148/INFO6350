//
//  SecondViewController.swift
//  SendMessageProtocol
//
//  Created by Jinzhou Yan on 2/18/22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var txtMessage: UITextField!
    var sendMessageDelegate : SendMessageDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendMsgAction(_ sender: Any) {
        sendMessageDelegate?.sendMessage(message: txtMessage.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
