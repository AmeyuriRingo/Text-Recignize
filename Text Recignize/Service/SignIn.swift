//
//  Authentication.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/20/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

class SignIn {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            // User is signed in
            // ...
        }
        // ...
    }
}
