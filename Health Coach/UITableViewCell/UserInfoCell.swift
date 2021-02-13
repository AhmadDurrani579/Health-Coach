//
//  UserInfoCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 20/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAge: UILabel!
//    @IBOutlet weak var lblSpeciality: UILabel!
    @IBOutlet weak var lblHobby: UILabel!
    
    @IBOutlet weak var txtOfAbout: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
