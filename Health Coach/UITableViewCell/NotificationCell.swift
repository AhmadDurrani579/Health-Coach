//
//  NotificationCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 31/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var imgOfProfile: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblNAme: UILabel!

    @IBOutlet weak var lblMinute: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
