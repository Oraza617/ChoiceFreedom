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

    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!

    @IBOutlet weak var Question: UILabel!
    
    
    func updateUI() {
        guard let nextEntry = entryArray.first else {
            return print("entry array is empty")
        }
        
        let currentQuestion = nextEntry.question
        self.Question.text = currentQuestion
        
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
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizerOne = UITapGestureRecognizer(target: self, action: #selector(leftImageTapped(tapGestureRecognizer:)))
        imageOne.addGestureRecognizer(tapGestureRecognizerOne)
        let tapGestureRecognizerTwo = UITapGestureRecognizer(target: self, action: #selector(rightImageTapped(tapGestureRecognizer:)))
        imageTwo.addGestureRecognizer(tapGestureRecognizerTwo)
        
        
    }
    
    @objc func leftImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        VoteService.create(isLeft: true, for: entryArray[0]) { (success) in
            if success == false {
                print("something went wrong")
            }
        }
        entryArray.removeFirst()
        updateUI()
        print("image tapped")
    }
    
    @objc func rightImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        VoteService.create(isLeft: false, for: entryArray[0]) { (success) in
            if success == false {
                print("something went wrong")
            }
        }
        entryArray.removeFirst()
        updateUI()
        print("image tapped")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

