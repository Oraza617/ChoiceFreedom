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
    
    static func create(imageOne: UIImage, imageTwo: UIImage, username: String, question: UITextField) {
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
                
                create(imageOneURL: downloadUrlOne, imageTwoURL: downloadUrlTwo, username: username, question: question)
            }
        }
}
    
    
    
    private static func create(imageOneURL: String, imageTwoURL: String,
                               username: String, question: UITextField) {
        
        let currentUser = username //This is subject to change once I put in the login info
        
        let entry = Entry(imageOneURL: imageOneURL, imageTwoURL: imageTwoURL,
                          question: question.text!, username: currentUser)
        
        let dict = entry.dictValue
        
        let entryRef = Database.database().reference().child(username).child("Entries")
        
        entryRef.updateChildValues(dict)
        
    }
    
    
    
    
    
    //Make two nested versions of the function above and store the URLs
    //seperately to call later into the relatime database
    
    
    //The private function here is what I should call with all the params
    //in order to create an instance of the entry in the realtiem database
}
