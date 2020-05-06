//
//  DetailsViewController.swift
//  HamiltonTevin_CE05
//
//  Created by Tevin Hamilton on 9/16/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //varible to capture data being passed from tableViewController
    var congress:Congress!
    
    //MARK: IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var viewColor: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // check if the congress object is nil
        if congress != nil
        {
            //add selected data to the proper labels and image
            nameLabel.text = congress.fullname
            titleLabel.text = congress.title
            partyLabel.text = congress.longParty.description
            stateLabel.text = congress.state
            //pass the current congress bio id into the addImage function
            AddImage(id: congress.id)
        }
        
        //change the view background color based on party values
        switch congress.party {
        case "R":
            viewColor.backgroundColor = UIColor.red
        case "D":
            viewColor.backgroundColor = UIColor.blue
        case "I":
            viewColor.backgroundColor = UIColor.yellow
        default:
            print("Somthing went wrong")
        }
        
    }
    
    func AddImage(id:String)
    {
        //convert string into url
        if let url = URL(string: "https://theunitedstates.io/images/congress/225x275/\(id).jpg")
        {
            do {
                //try to convert to data
                let data = try Data(contentsOf: url)
                image.image = UIImage(data: data)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
