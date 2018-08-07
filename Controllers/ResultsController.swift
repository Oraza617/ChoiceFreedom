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
        
        cell.voteCountLeftImage.text = String(entry.imageOneCounter)
        cell.voteCountRightImage.text = String(entry.imageTwoCounter)

        
        cell.setGradientForResultTableViewBackground(colorOne: Colors.kindaOwaisBlue, colorTwo: Colors.kindaOwaisBlue)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

