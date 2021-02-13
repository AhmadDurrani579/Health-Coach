//
//  AppointMentCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 29/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class AppointMentCell: UITableViewCell {

    @IBOutlet weak var viewOfCalender: FSCalendar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
