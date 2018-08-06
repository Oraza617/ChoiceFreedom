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
 
        
        let ref = Database.database().reference().child("Entries")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else{
                return completion([])
                
            }
            
            var entryArray = [Entry]()
            
            for childSnapshot in snapshot {
                if let entry = Entry(snapshot: childSnapshot) {
                    entryArray.append(entry)
                }
            }
            
            
            //
            
            fetchVotes(completion: { (entriesTheCurrentUserHasVotedFor) in
                
                //new function
                
                //only entries not from current user
                let filteredArray = entryArray.filter({ (aEntry) -> Bool in
                    
                    if aEntry.userID == User.current.uid {
                        return false
                    }
                    
                    //Add another filter to check whether the user has already voted for it (use the below model)
                    let userHasAlreadyVotedForA_Entry = entriesTheCurrentUserHasVotedFor.contains(where: { (entryuid) -> Bool in
                        return entryuid == aEntry.key
                    })
                    
                    if userHasAlreadyVotedForA_Entry {
                        return false
                    }
                    
                    return true
                })
                
                
                completion(filteredArray)
            })
            
        })
    }
    
    static func fetchVotes(completion: @escaping ([String]) -> Void) {
        
        
        let ref = Database.database().reference().child("votes")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else{
                return completion([])
            }
            
            var keys: [String] = []
            
            
            
            
            completion(keys)
        })
    }
    
    //Refactoring login view controllers authentication process
    
    static func show    (forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
    
}

