//
//  AlertController.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/23/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class Alert  {
    
    func alert(errorText: String?) -> UIAlertController {
        
        let alert = UIAlertController(title: "Error", message: errorText ?? "", preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(alertButton)
        return alert
    }
    
    func register() {
        let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { textEmail in textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
    }
}

