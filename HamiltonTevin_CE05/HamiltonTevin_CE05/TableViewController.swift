//
//  TableViewController.swift
//  HamiltonTevin_CE05
//
//  Created by Tevin Hamilton on 9/16/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // an array containing congress object
    var congress = [Congress]()
    
    // an array that hold other congress array
    //index 0 = republicans
    //index 1 = Democratic
    // index 2 = indepented
    var filteredCongress = [[Congress]() ,[Congress]() ,[Congress]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call func to download sentate data
        DownLoadJsonDataSenate()
        
        // call function to download house data
        DownLoadJsonDataHouse()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredCongress[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell_ID1", for: indexPath) as? CongressCell
            else{
                return tableView.dequeueReusableCell(withIdentifier: "cell_ID1" , for: indexPath)
        }
        // add data to custom cells
        let currentCongress = filteredCongress[indexPath.section][indexPath.row]
        
        cell.nameLabel?.text = currentCongress.fullname.description
        cell.titleLabel?.text = currentCongress.title
        cell.partyAndStateLabel?.text = currentCongress.PartyAndState
        
        //change cell back ground color based on current section
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor.red
        case 1:
            cell.backgroundColor = UIColor.blue
        case 2:
            cell.backgroundColor = UIColor.yellow
        default:
            print("Something went wrong")
        }
        
        return cell
    }
    
    //create sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Republicans"
        case 1:
            return "Democrats"
        case 2:
            return "Indepent"
        default:
            return "mistake made"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //get the selected row in the table view
        if let indexPath = tableView.indexPathForSelectedRow
        {
            let postToSend = filteredCongress[indexPath.section][indexPath.row]
            
            if let destination = segue.destination as? DetailsViewController
            {
                //pass data to view controler
                destination.congress = postToSend
            }
        }
    }
    
    
}
