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
    var myImageURLs = [(url1: String, url2: String)]()
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dispatchQueue = DispatchGroup()
        
        //loading overlay here
        
        dispatchQueue.enter()

        UserService.fetchEntryArray { (entryArray) in
            for entry in entryArray {
                self.entryArray.append(entry)
            }
            
            //hide overlay here
            
            dispatchQueue.leave()
        }
        
        dispatchQueue.notify(queue: DispatchQueue.main) {
            for entry in self.entryArray {
                let imageTuple = (entry.imageOneURL, entry.imageTwoURL)
                self.myImageURLs.append(imageTuple)
            }
            
            let displayImageOneUrl = URL(string: self.myImageURLs[0].url1)
            self.imageOne.kf.setImage(with: displayImageOneUrl)
            
            let displayImageTwoURl = URL(string: self.myImageURLs[0].url2)
            self.imageTwo.kf.setImage(with: displayImageTwoURl)
            print(self.myImageURLs)
            
            
            //set random image tuple here
            
            
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

