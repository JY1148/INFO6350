//
//  KeychainService.swift
//  LoginApp
//
//  Created by Jinzhou Yan on 3/27/22.
//

import Foundation
import KeychainSwift

class KeychainService {
    var _keyChain = KeychainSwift()
    var keyChain : KeychainSwift{
        
        get{
          return _keyChain
        }
        
        set{
          _keyChain = newValue
        }
    }
    
}
