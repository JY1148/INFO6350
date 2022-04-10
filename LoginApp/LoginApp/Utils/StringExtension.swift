//
//  StringExtension.swift
//  LoginApp
//
//  Created by Jinzhou Yan on 3/27/22.
//

import Foundation

extension String {

    var isEmail: Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: self)

    }
    
    var isValidPassword: Bool {
        
        let passwordRegEx = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$";
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        
//        return passwordTest.evaluate(with: self)
        return true
    }

}
