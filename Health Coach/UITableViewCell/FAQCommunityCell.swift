//
//  FAQCommunityCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 29/01/2020.
//  Copyright © 2020 WinSoft. All rights reserved.
//

import UIKit

class FAQCommunityCell: UITableViewCell {

//    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var lblTitleOfQuestion: UILabel!
    
    
    @IBOutlet weak var lblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
