//
//  User.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 7/31/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation

class User {
    
    // MARK: - Properties
    
    let uid: String
    let username: String
    
    // MARK: - Init
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
}
