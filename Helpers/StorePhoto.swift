//
//  StoringPhotos.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 7/25/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation
import Firebase

struct StorePhoto {
    
func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {

    guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
        return completion(nil)
    }
    

    reference.putData(imageData, metadata: nil, completion: { (metadata, error) in

        if let error = error {
            assertionFailure(error.localizedDescription)
            return completion(nil)
        }
        

        reference.downloadURL(completion: { (url, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            completion(url)
        })
    })
    }
}

