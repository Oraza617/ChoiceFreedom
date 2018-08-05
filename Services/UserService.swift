//
//  UserService.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 8/1/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    
    //Writting to the database for a single user
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        
        let userAttrs = ["username": username]
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    //Reading from the database in order to display on the home page
    static func displayPost(completion: @escaping (Entry) -> Void) {
        let ref = Database.database().reference().child("Entries").child("MODLC5cQwOdkF2aWedbNP9CriKq2").child("-LJ5re2vDK8KL5hSLoOu") //if something goes wrong for UID you changed it rmbr

        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            //let snapshot = snapshot.value as? DataSnapshot 
            let entry = Entry(snapshot: snapshot)
            completion(entry!)
        })
    }
    
    //Refactoring login view controllers authentication process

        static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
            let ref = Database.database().reference().child("users").child(uid)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let user = User(snapshot: snapshot) else {
                    return completion(nil)
                }
                
                completion(user)
            })
        }

}
