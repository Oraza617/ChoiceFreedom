//
//  LoginViewController.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 7/31/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    //Global variable
    typealias FIRUser = FirebaseAuth.User
    
    //Button for logging in
    @IBOutlet weak var loginButton: UIButton!
    
    
    //Allows the signing up of a new or existing user
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}




//Responsible for user authentication
extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser,
                authDataResult: AuthDataResult?, error: Error?) {
        
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let user = authDataResult?.user
            else { return }
        
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let userDict = snapshot.value as? [String : Any] {
                print("User already exists \(userDict.debugDescription).")
            } else {
                print("New user!")
            }
            
        })

    }
    

    
    
}

