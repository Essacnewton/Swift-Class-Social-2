//
//  SignInVC.swift
//  Swift Class Social 2
//
//  Created by Isaac Prunty on 2/25/17.
//  Copyright © 2017 Isaac Prunty. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailFieldSCS2: FancyTextField!
    @IBOutlet weak var pwdField: FancyTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func facebookBtnTapped(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("ISAAC: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("ISAAC: User cancelled facebook authentication")
            } else {
                print("ISAAC: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("ISAAC: Unable to authenticate with Firebase - \(error)")
            } else {
                print("ISAAC: Successfully authenticated with Firebase")
            }
        })
    }

    @IBAction func SignInBtnPressed(_ sender: FancyLoginButton) {
        
        if let email = emailFieldSCS2.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("ISAAC: Email user authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("ISAAC: Unable to authenticate with Firebase using email")
                        } else {
                            print("ISAAC: Successfully authenticated with Firebase")
                        }
                    })
                }
            })
        }
    }
    

}

