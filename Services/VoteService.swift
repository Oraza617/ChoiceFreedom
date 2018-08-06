//
//  VoteService.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 8/6/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct VoteService {
    
    static func create(isLeft: Bool, for entry: Entry, success: @escaping (Bool) -> Void) {
        
        guard let key = entry.key else {
            return success(false)
        }

        let currentUID = User.current.uid
        
        let votesRef = Database.database().reference().child("votes").child(currentUID).child(key)
        votesRef.setValue(true) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }
            
            let voteCountRef: DatabaseReference
            if isLeft == true {
                voteCountRef = Database.database().reference().child("Entries").child(key).child("imageOneCounter")
            } else {
                voteCountRef = Database.database().reference().child("Entries").child(key).child("imageTwoCounter")
            }
                
            voteCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
                let currentCount = mutableData.value as? Int ?? 0
                
                mutableData.value = currentCount + 1
                
                return TransactionResult.success(withValue: mutableData)
            }, andCompletionBlock: { (error, _, _) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    success(false)
                } else {
                    success(true)
                }
            })
        }
        
    }
    
    
    
    
    
    
    
}
