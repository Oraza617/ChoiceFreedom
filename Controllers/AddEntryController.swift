//
//  ViewController.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 7/23/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import UIKit
import Firebase

class AddEntryController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //All Entry Outlets
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playButtonTwo: UIButton!
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    
    // First button
    @IBAction func UploadFirstImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        playButton.isSelected = true
        playButtonTwo.isSelected = false
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            //code after it's completed
            
        }
    }
    
    //Allows user to add images to their entry
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if playButton.isSelected{
                //Sets button1 background image
                playButton.setBackgroundImage(image, for: .normal)
            }
            if playButtonTwo.isSelected {
                //Sets button2 background image
                playButtonTwo.setBackgroundImage(image, for: .normal)
            }
            
        } else {
            //error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func UploadSecondImage(_ sender: Any) {
        let imageTwo = UIImagePickerController()
        
        imageTwo.delegate = self
        
        playButton.isSelected = false
        playButtonTwo.isSelected = true
        
        imageTwo.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imageTwo.allowsEditing = false
        self.present(imageTwo, animated: true) {
        }
        
    }
    
    
    @IBAction func SubmitEntry(_ sender: Any) {
        if playButton.currentBackgroundImage != nil &&
            playButtonTwo.currentBackgroundImage != nil {
            
            //"Username" needs to be changed after login functionality is added
            PostPhoto.create(imageOne: playButton.currentBackgroundImage!, imageTwo: playButtonTwo.currentBackgroundImage!, username: "Owais", question: question)
        
        } else {
            print("it isn't working")
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.isSelected = false
        playButtonTwo.isSelected = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

