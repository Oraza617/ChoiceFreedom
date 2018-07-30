//
//  StorageReference+Post.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 7/30/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation
import Firebase

extension StorageReference {
    
    static let dateFormatter = ISO8601DateFormatter()
    
    static func newPostImageReference() -> StorageReference {
        let uid = "username" //add actual username when you implement login page
        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("\(uid)/entries/\(timestamp).jpg")
        
        
        
    }
    
}
