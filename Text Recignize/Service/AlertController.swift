//
//  AlertController.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/23/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class Alert  {
    
    func alert(errorText: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(alertButton)
        return alert
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
