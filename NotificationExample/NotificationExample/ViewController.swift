//
//  ViewController.swift
//  NotificationExample
//
//  Created by Jinzhou Yan on 2/13/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblFirstName: UILabel!
    
    @IBOutlet weak var lblLastName: UILabel!
    
    let nameNotif = Notification.Name(nameNotification)
    
    //call deinit when things done
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToNotification()
        // Do any additional setup after loading the view.
    }

    @IBAction func gotoProfile(_ sender: Any) {
        performSegue(withIdentifier: "SegueProfile", sender: self)
    }
    
    @IBAction func gotoFormEntry(_ sender: Any) {
        performSegue(withIdentifier: "SegueFormEntry", sender: self)
    }
    func subscribeToNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(getName), name: nameNotif, object: nil)
    }
    
    @objc func getName(notif : NSNotification){
        print("I am here")
        
        if let dict = notif.userInfo as NSDictionary? {
            if let firstName = dict["FirstName"] as? String{
                lblFirstName.text = firstName
            }
            if let lastName = dict["LastName"] as? String{
                lblLastName.text = lastName
            }
        }
    }
}

