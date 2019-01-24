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
        let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(alertButton)
        alert.message = errorText
        return alert
    }
}
