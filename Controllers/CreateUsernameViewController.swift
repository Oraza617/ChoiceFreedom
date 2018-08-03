//
//  CreateUsername.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 7/31/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    //Textfield and next button
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    //View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //When "next" is tapped
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return } // Handle error
            
            User.setCurrent(user, writeToUserDefaults: true)

            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
            print("Created new user: \(user.username)")
            
            }
        
        
        }
    }

