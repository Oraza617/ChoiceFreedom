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
    
    var username: String
    var question: String
    var imageOneURL: String
    var imageTwoURL : String
    let imageOneCounter: Int = 0
    let imageTwoCounter: Int = 0
    
    var dictValue: [String : Any] { //Creating dictionary to store entire entry of data
        return ["username" : username,
                "question" : question,
                "imageOneURL" : imageOneURL,
                "imageTwoURL" : imageTwoURL,
                "imageOneCounter" : imageOneCounter,
                "imageTwoCounter" : imageTwoCounter]
    }
    
    init(imageOneURL: String, imageTwoURL: String, question: String, username: String) {
        self.question = question
        self.imageOneURL = imageOneURL
        self.imageTwoURL = imageTwoURL
        self.username = username
        
    }
    
}
