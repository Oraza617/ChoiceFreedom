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
    
    //Refactoring login view controllers autehntication process

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
