//
//  ViewController.swift
//  SendMessageProtocol
//
//  Created by Jinzhou Yan on 2/18/22.
//

import UIKit

class ViewController: UIViewController, SendMessageDelegate {
    
    @IBOutlet weak var lblWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getMsgAction(_ sender: Any) {
        performSegue(withIdentifier: "segueSendMsg", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSendMsg"{
            let secondVC = segue.destination as! SecondViewController
            
            secondVC.sendMessageDelegate = self;
        }
    }
    func sendMessage(message: String) {
        lblWelcome.text = message
    }
}

