//
//  ViewController.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 7/23/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import UIKit
import Firebase


class ResultsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var entryArray: [Entry] = [Entry]() {
        didSet {
            resultsTableView.reloadData()
        }
    }
    @IBOutlet weak var resultsTableView: UITableView!
    
    @IBOutlet weak var myResultsLabel: UILabel!
    // copy and paste the fetch entry function and delete all the filters except for the curren uid thing and instead of false make it true and then call all of the shits here.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserService.fetchResultsArray { (entryArray) in
            self.entryArray = entryArray
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = entryArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultCell
        let imageOneUrl = URL(string: entry.imageOneURL)
        cell.imageToTheLeft.kf.setImage(with: imageOneUrl)
        let imageTwourl = URL(string: entry.imageTwoURL)
        cell.imageToTheRight.kf.setImage(with: imageTwourl)
        cell.questionLabel.text = entry.question
        
        let totalImageCounts = entry.imageOneCounter + entry.imageTwoCounter
        
        // Calculate the % if the both pictures have a vote count that's greater than 0, otherwise just display the numbers
        if (entry.imageOneCounter > 0 && entry.imageTwoCounter > 0) {
            let leftImagePercentage = (Double(entry.imageOneCounter) / Double(totalImageCounts)) * 100
            let rightImagePercentage = ((Double(entry.imageTwoCounter) / Double(totalImageCounts)) * 100)
            
            // Properly format to only display the numerical % and no values after the decimal
            cell.voteCountLeftImage.text = String(format: "%.f", leftImagePercentage) + "% (" + String(entry.imageOneCounter) + ")"
            cell.voteCountRightImage.text = String(format: "%.f", rightImagePercentage) + "% (" + String(entry.imageTwoCounter) + ")"
        }
        
        // Only displaying the numbers if either of the counts are not greater than 0
        else {
            cell.voteCountLeftImage.text = String(entry.imageOneCounter)
            cell.voteCountRightImage.text = String(entry.imageTwoCounter)
        }
        
        cell.setGradientForResultTableViewBackground(colorOne: Colors.kindaOwaisBlue, colorTwo: Colors.kindaOwaisBlue)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myResultsLabel.adjustsFontSizeToFitWidth = true
        myResultsLabel.minimumScaleFactor = 0.2
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

