//
//  CongressCell.swift
//  HamiltonTevin_CE05
//
//  Created by Tevin Hamilton on 9/16/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import UIKit

class CongressCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var partyAndStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
