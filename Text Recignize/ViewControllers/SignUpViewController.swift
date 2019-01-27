//
//  SignUpViewController.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/27/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    static func storyboardInstance() -> SignUpViewController? {
//        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
//        return storyboard.instantiateInitialViewController() as? SignUpViewController
//    }
    
    @IBAction func signUp(_ sender: UIButton) {
        
        let alert = Alert()
        if alert.isValidEmail(testStr: email.text!) {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
                guard (authResult?.user) != nil else { return }
//                if let nextViewController = TextRecognizeViewController.storyboardInstance() {
//                    self.navigationController?.pushViewController(nextViewController, animated: true)
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
