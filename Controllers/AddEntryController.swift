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
    
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    //All of this happens when the view controller is loaded (this occurs once)
    override func viewDidLoad() {
        super.viewDidLoad()
        topImage.isHighlighted = false
        bottomImage.isHighlighted = false

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func topImageClicked(_ sender: Any) {
        print("image is tapped")
        topImage.isHighlighted = true
        bottomImage.isHighlighted = false
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = true
        self.present(image, animated: true) {
    }
}
    @IBAction func bottomImageClicked(_ sender: Any) {
        print("image tapped")
        topImage.isHighlighted = false
        bottomImage.isHighlighted = true
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = true
        self.present(image, animated: true) {
    }
}
        

    //Allows user to add images to their entry
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            //Checks where the user wants to place their selected image
            if topImage.isHighlighted == true {
                let croppedImage = cropToBounds(image: image, width: 750, height: 750)
                topImage.image = croppedImage
                
            } else if bottomImage.isHighlighted{
                let croppedImage = cropToBounds(image: image, width: 750, height: 750)
                bottomImage.image = croppedImage
            }
            } else {
            //error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func SubmitEntry(_ sender: Any) {
        if topImage.image != nil &&
            bottomImage.image != nil {
            
            //Creates the URLs for each image and eventaully sends entire entry to Firebase
            PostPhoto.create(imageOne: topImage.image!, imageTwo: bottomImage.image!, userID: User.current.uid, question: question)
            
            // Creates a pop up to let user know their entry has been submitted
            let refreshAlert = UIAlertController(title: "Entry Submitted. Thanks!", message: "", preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            }))
            present(refreshAlert, animated: true, completion: nil)
            
            // Clear out the question on top after user submits entry
            question.text = ""

            // This removes the images from the view once they're submitted
            topImage.image = UIImage(named: "add-image")
            bottomImage.image = UIImage(named: "add-image")
            
        } else {
            print("it isn't working")
            
        }
    }
    
    //Crops image that user selects to a 1:1 ratio and retains quality
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
