//
//  MembersTableViewCell.swift
//  lagc
//
//  Created by Patel Niket M on 10/15/17.
//  Copyright © 2017 ESyz Solutions. All rights reserved.
//

import UIKit

class CommitteeMembersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memberAvatar: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberDesignation: UILabel!
    @IBOutlet weak var memberContactDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
