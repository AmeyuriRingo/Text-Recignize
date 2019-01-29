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
    
    @IBOutlet weak var email: UITextField?
    @IBOutlet weak var password: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { _, user in
            if user != nil {
                self.performSegue(withIdentifier: "loginToRecognize", sender: nil)
                self.email?.text = nil
                self.password?.text = nil
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToSignUp(_ sender: UIButton) {
        
        let alertNotification = Alert()
        let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let emailField = alert.textFields?[0]
            let passwordField = alert.textFields?[1]
            
            Auth.auth().createUser(withEmail: emailField?.text ?? "", password: passwordField?.text ?? "") { user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.email?.text ?? "", password: self.password?.text ?? "")
                } else {
                    self.present((alertNotification.alert(errorText: error?.localizedDescription)), animated: true, completion: nil)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { textEmail in textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func login(_ sender: Any) {
    
        let alert = Alert()
        if isValidEmail(testStr: email?.text ?? ""), let _ = password?.text {
            
            guard let email = email?.text, let password = password?.text, email.count > 0, password.count > 0
                else { return }
            
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if let error = error, user == nil {
                    self.present(alert.alert(errorText: error.localizedDescription), animated: true, completion: nil)
                }
            }
        } else {
            if email?.text?.isEmpty ?? false || password?.text?.isEmpty ?? false {
                present((alert.alert(errorText: "Email's or password form is empty")), animated: true, completion: nil)
            } else {
                present((alert.alert(errorText: "Email's form is incorrect")), animated: true, completion: nil)
            }
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
