//
//  ReceiverImageCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 25/11/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class ReceiverImageCell: UITableViewCell {
    
    @IBOutlet weak var imgOfReceiver: UIImageView!
    @IBOutlet weak var imgOfUser: UIImageView!

    @IBOutlet weak var lblTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
