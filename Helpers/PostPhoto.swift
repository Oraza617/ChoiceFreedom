//
//  PostingPhoto.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 7/26/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostPhoto {
    
    static func create(imageOne: UIImage, imageTwo: UIImage, userID: String, question: UITextField) {
        var downloadUrlOne: String = ""
        var downloadUrlTwo: String = ""
        
        let imageRefOne = StorageReference.newPostImageReference()
        StorePhoto().uploadImage(imageOne, at: imageRefOne) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            downloadUrlOne = downloadURL.absoluteString
            
            let imageRefTwo = StorageReference.newPostImageReference()
            StorePhoto().uploadImage(imageTwo, at: imageRefTwo) { (downloadURL) in
                guard let downloadURL = downloadURL else {
                    return
                }
                
                downloadUrlTwo = downloadURL.absoluteString
                
                create(imageOneURL: downloadUrlOne, imageTwoURL: downloadUrlTwo, userID: userID, question: question)
            }
        }
}
    
    
    
    private static func create(imageOneURL: String, imageTwoURL: String,
                               userID: String, question: UITextField) {
        
        let currentUser = User.current
        
        let entry = Entry(imageOneURL: imageOneURL, imageTwoURL: imageTwoURL,
                          question: question.text!, userID: currentUser.uid)
        
        let dict = entry.dictValue
    
        let entryRef = Database.database().reference().child("Entries").child(currentUser.uid).childByAutoId()
        
        entryRef.updateChildValues(dict)
        
    }
}
