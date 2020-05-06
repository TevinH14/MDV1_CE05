//
//  Senate.swift
//  HamiltonTevin_CE05
//
//  Created by Tevin Hamilton on 9/17/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import Foundation

class Congress
{
    //MARK:stored Properties
    let title:String
    let fName:String
    let lName:String
    let party:String
    let state:String
    let id:String
    
     //init
    init(title:String, fName:String, lName:String, party:String, state:String, id:String)
    {
        self.title = title
        self.fName = fName
        self.lName = lName
        self.party = party
        self.state = state
        self.id = id
    }
    
    //Computed Properties
    //get fullname
    var fullname:String
    {
        return "\(fName), \(lName)"
    }
    
    //get party and string
    var PartyAndState:String
    {
        return party+"-"+state
    }
    
    //switch charater ro a string.
    var longParty:String
    {
        var partyStatus = ""
        
        switch party {
        case "R":
            partyStatus = "Republican"
        case "D":
            partyStatus = "Democratic"
        case "I":
            partyStatus = "Independent"
        default:
            print("something went wrong")
        }
        return partyStatus
    }
}
