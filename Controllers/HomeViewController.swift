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
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    func updateUI() {
        if let nextEntry = entryArray.first {
            let currentQuestion = nextEntry.question.uppercased()
            self.Question.text = currentQuestion
            let displayImageOneUrl = URL(string: nextEntry.imageOneURL)
            self.imageOne.kf.setImage(with: displayImageOneUrl)
            let displayImageTwoURl = URL(string: nextEntry.imageTwoURL)
            self.imageTwo.kf.setImage(with: displayImageTwoURl)
        } else {
            Question.text = "No entries available at this time"
            imageOne.image = nil
            imageTwo.image = nil
            imageOne.isUserInteractionEnabled =  false
            imageTwo.isUserInteractionEnabled = false
        }
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
    
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        self.present(alertController, animated: true, completion: nil)
        let logoutAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
            let initialViewController = UIStoryboard.initialViewController(for: .login)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        })
        
        alertController.addAction(logoutAction)
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alertController.addAction(cancelAction)
    }
    
    //Allows user to flag a post
    @IBAction func flagPost(_ sender: Any) {
        //let poster = entryArray[0].poster
        
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    //        if poster.uid != User.current.uid {
                let flagAction = UIAlertAction(title: "Report as Inappropriate", style: .default, handler: { action in
                        FlagService.flag(self.entryArray[0])
                        self.entryArray.removeFirst()
                        self.updateUI()
                        print("report post")
                        let okAlert = UIAlertController(title: nil, message: "The post has been flagged.", preferredStyle: .alert)
                        okAlert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(okAlert, animated: true)

                })
                
                alertController.addAction(flagAction)
            //}
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

