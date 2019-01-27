//
//  LoginViewController.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/27/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToSignUp(_ sender: UIButton) {
        
//        if let nextViewController = SignUpViewController.storyboardInstance() {
//            navigationController?.pushViewController(nextViewController, animated: true)
//        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        let alert = Alert()
        if alert.isValidEmail(testStr: email.text!) {
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
                if error != nil {
                    self.present((alert.alert(errorText: "Login or password is incorrect")), animated: true, completion: nil)
                }
//                else {
//                    if let nextViewController = TextRecognizeViewController.storyboardInstance() {
//                        self.present(nextViewController, animated: true, completion: nil)
//                    }
//                }
            }
        } else {
            present((alert.alert(errorText: "Email's form is incorrect")), animated: true, completion: nil)
        }
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
