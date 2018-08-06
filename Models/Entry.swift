//
//  EntryModel.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 7/24/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation
import Firebase

struct Entry {
    
    var key: String! = nil
    var userID: String
    var question: String
    var imageOneURL: String
    var imageTwoURL : String
    var imageOneCounter: Int = 0
    var imageTwoCounter: Int = 0
    
    var dictValue: [String : Any] { //Creating dictionary to store entire entry of data
        return ["username" : userID,
                "question" : question,
                "imageOneURL" : imageOneURL,
                "imageTwoURL" : imageTwoURL,
                "imageOneCounter" : imageOneCounter,
                "imageTwoCounter" : imageTwoCounter]
    }
    
        init?(snapshot: DataSnapshot) {
            guard let dict = snapshot.value as? [String : Any],
                let imageOneURL = dict["imageOneURL"] as? String,
                let imageTwoURL = dict["imageTwoURL"] as? String,
                let username = dict["username"] as? String,
                let question = dict["question"] as? String,
                let imageOneCounter = dict["imageOneCounter"] as? Int,
                let imageTwoCounter = dict["imageTwoCounter"] as? Int
                else { return nil }

            self.key = snapshot.key
            self.imageOneURL = imageOneURL
            self.imageTwoURL = imageTwoURL
            self.question = question
            self.userID = username
            self.imageOneCounter = imageOneCounter
            self.imageTwoCounter = imageTwoCounter
        }
    
    
    init(imageOneURL: String, imageTwoURL: String, question: String, userID: String ) {
        self.question = question
        self.imageOneURL = imageOneURL
        self.imageTwoURL = imageTwoURL
        self.userID = userID
        
    }
    
}
