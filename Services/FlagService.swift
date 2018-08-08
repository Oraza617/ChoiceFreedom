//
//  FlagService.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 8/8/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

func flag(_ Entry: Entry) {

    guard let entryKey = Entry.key else { return }
    
    let flaggedPostRef = Database.database().reference().child("flaggedPosts").child(entryKey)
    
    let flaggedDict = ["Entry_id" : Entry.key,
                       "Poster_Uid": Entry.poster.uid,
                       "reporter_uid": User.current.uid]
    
    flaggedPostRef.updateChildValues(flaggedDict)
    
    let flagCountRef = flaggedPostRef.child("flag_count")
    flagCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
        let currentCount = mutableData.value as? Int ?? 0
        
        mutableData.value = currentCount + 1
        
        return TransactionResult.success(withValue: mutableData)
    })
}
