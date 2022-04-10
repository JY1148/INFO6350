//
//  DashboardViewController.swift
//  LoginApp
//
//  Created by Jinzhou Yan on 3/27/22.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logoutAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        
        do{
            try firebaseAuth.signOut()
            KeychainService().keyChain.delete("uid")
            self.navigationController?.popViewController(animated: true)
        }
        catch let signoutError as NSError{
            print(signoutError.localizedDescription)
            return
        }
        
    }
    

}
