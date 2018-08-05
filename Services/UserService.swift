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
    static func fetchEntryArray(completion: @escaping ([Entry]) -> Void) {
        var entryArray = [Entry]()
        
        
        //if child.key != User.current.uid {
        //......normal stuff here....
        //}
        
        let ref = Database.database().reference().child("Entries").child(User.current.uid) 
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else{
                return completion([])
                
            }
            
            for childSnapshot in snapshot {
                if let entry = Entry(snapshot: childSnapshot) {
                     entryArray.append(entry)
                }
            }
            completion(entryArray)
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
