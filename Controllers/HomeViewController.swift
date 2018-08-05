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
    
    var entry: Entry?
//    var entries = [Entry]() // Just an array of the Entrys that are made
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserService.displayPost { [unowned self] (entry) in
            self.entry = entry
        }
        
        let imageOneUrl = URL(string: (entry?.imageOneURL)!)
        imageOne.kf.setImage(with: imageOneUrl)
        
        let imageTwoUrl = URL(string: (entry?.imageTwoURL)!)
        imageTwo.kf.setImage(with: imageTwoUrl)
        
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

