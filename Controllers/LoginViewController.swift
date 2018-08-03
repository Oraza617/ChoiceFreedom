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



//Global variable
typealias FIRUser = FirebaseAuth.User


extension LoginViewController: FUIAuthDelegate {
    
    //Responsible for user authentication
    func authUI(_ authUI: FUIAuth, didSignInWith
                authDataResult: AuthDataResult?, error: Error?) {
        
        guard let user = authDataResult?.user //Potentially what causes an error bc I'm redeclaring what user is but without this it doesn't work so idk
          else { return }
        
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
            } else {
                // handle new user
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
    }

    
}
    
    


