//
//  TVC_Extension.swift
//  HamiltonTevin_CE05
//
//  Created by Tevin Hamilton on 9/16/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import Foundation
import UIKit

// private api for URL download
private var apiKey = "U5eNDFQH907gPxsoNHa2M6HhahwXpj3LUfTZUzi7"

//extension of to the TableVieController to provide data for the project
extension TableViewController
{
    func DownLoadJsonDataSenate()
    {
        // create a deafult confifuration
        let config = URLSessionConfiguration.default
        
        //create a seesion
        let session = URLSession(configuration: config)
        
        //valoidate the url to make sure it is not broken link
        if let validURL = URL(string: "https://api.propublica.org/congress/v1/115/senate/members.json")
        {
            var request = URLRequest(url: validURL)
            
            //set the heard value and pass api key
            request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
            
            //the type of request
            request.httpMethod = "GET"
            
            //create task to send the request and download whatever is found in vaild url
            let task = session.dataTask(with: request, completionHandler:  { (data, response, error) in
                
                //check for errors
                if let error = error
                {
                    print("data task failed with error" + error.localizedDescription)
                }
                
                print("success")
                // get http respeee for thr givrn zaUZRz
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    let validData = data
                    else{print("json creation failed error");return}
                do
                {
                    //pzrse data to json
                    let jsonObj = try! JSONSerialization.jsonObject(with: validData, options: .mutableLeaves ) as? [String: Any]
                    
                    guard let json = jsonObj
                        else {print("something went wrong");return}
                    
                    //reach first level data
                    for firstLevel in json
                    {
                        guard let dataOne = firstLevel.value as? [[String: Any]]
                            else{continue}
                        //reache second level data
                        
                        for secLevel in dataOne
                        {
                            guard let dataTwo = secLevel ["members"] as? [[String: Any]]
                                else {continue}
                            
                            //loop through members araay
                            for members in dataTwo
                            {
                                
                                guard let id = members ["id"] as? String,
                                    let title = members ["title"] as? String,
                                    let fName = members ["first_name"] as? String,
                                    let lName = members ["last_name"] as? String,
                                    let party = members ["party"] as? String,
                                    let state = members ["state"] as? String
                                    else {continue}
                                
                                //add object to congress array
                                self.congress.append(Congress(title: title, fName: fName, lName: lName, party: party, state: state,id: id))
                                
                            }
                        }
                    }
                    
                }
                
                //call to the main thred
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            //start task
            task.resume()
            
        }
    }
    
    func DownLoadJsonDataHouse()
    {
        // create a deafult confifuration
        let config = URLSessionConfiguration.default
        
        //create a seesion
        let session = URLSession(configuration: config)
        
        //valoidate the url to make sure it is not broken link
        if let validURL = URL(string: "https://api.propublica.org/congress/v1/115/house/members.json")
        {
            var request = URLRequest(url: validURL)
            
            //set the heard value and pass api key
            request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
            
            //the type of request
            request.httpMethod = "GET"
            
            //create task to send the request and download whatever is found in vaild url
            let task = session.dataTask(with: request, completionHandler:  { (data, response, error) in
                
                if let error = error
                {
                    print("data task failed with error" + error.localizedDescription)
                }
                
                print("success")
                
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    let validData = data
                    else{print("json creation failed error");return}
                do
                {
                    let jsonObj = try! JSONSerialization.jsonObject(with: validData, options: .mutableLeaves ) as? [String: Any]
                    
                    guard let json = jsonObj
                        else {print("something went wrong");return}
                    
                    for firstLevel in json
                    {
                        guard let dataOne = firstLevel.value as? [[String: Any]]
                            else{continue}
                        
                        for secLevel in dataOne
                        {
                            guard let dataTwo = secLevel ["members"] as? [[String: Any]]
                                else {continue}
                            
                            
                            for members in dataTwo
                            {
                                guard let id = members ["id"] as? String,
                                    let title = members ["title"] as? String,
                                    let fName = members ["first_name"] as? String,
                                    let lName = members ["last_name"] as? String,
                                    let party = members ["party"] as? String,
                                    let state = members ["state"] as? String
                                    else {continue}
                                self.congress.append(Congress(title: title, fName: fName, lName: lName, party: party, state: state,id: id))
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    
                    //sort through data
                    self.AddToSelectedArray()
                    self.tableView.reloadData()
                }
            })
            //star task
            task.resume()
        }
    }
    
    //addad to to the correct nested array to be in point
    func AddToSelectedArray()
    {
        for item in congress
        {
            switch item.party {
            case "R":
                filteredCongress[0].append(item)
            case "D":
                filteredCongress[1].append(item)
            case "I":
                filteredCongress[2].append(item)
            default:
                print("Somthing went wrong")
            }
        }
        
    }
    
}
