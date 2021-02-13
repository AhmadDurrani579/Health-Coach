//
//  ProfileHeaderCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 22/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {
    
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblBMI: UILabel!
    @IBOutlet weak var lblMuscle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
