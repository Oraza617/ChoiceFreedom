//
//  ViewController.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 7/23/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    var entryArray: [Entry] = [Entry]()
//    var myImageURLs = [(url1: String, url2: String)]()
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!


    
    func updateUI() {
        guard let nextEntry = entryArray.first else {
            return print("entry array is empty")
        }
        
        let displayImageOneUrl = URL(string: nextEntry.imageOneURL)
        self.imageOne.kf.setImage(with: displayImageOneUrl)

        let displayImageTwoURl = URL(string: nextEntry.imageTwoURL)
        self.imageTwo.kf.setImage(with: displayImageTwoURl)
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dispatchQueue = DispatchGroup()
        
        //add loading overlay here (still needs to be implemented)
        
        dispatchQueue.enter()

        UserService.fetchEntryArray { (entryArray) in
            self.entryArray = entryArray
            
            
            //hide overlay here (still needs to be implemented)
            
            self.updateUI()
            dispatchQueue.leave()
        }
        
        dispatchQueue.notify(queue: DispatchQueue.main) {
            
            
        }
        
    }
    
    //on image click function
    //display another random tuple pair of images
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

