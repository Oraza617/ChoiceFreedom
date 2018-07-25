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
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playButtonTwo: UIButton!
    
    // first button
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if playButton.isSelected{
                 playButton.setBackgroundImage(image, for: .normal)
            }
            if playButtonTwo.isSelected {
                playButtonTwo.setBackgroundImage(image, for: .normal)
                // playButton.imageView?.image
                // playButtonTwo.imageView?.image
                
                // create a new post
                // pass all param
                // upload to storage
                
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

