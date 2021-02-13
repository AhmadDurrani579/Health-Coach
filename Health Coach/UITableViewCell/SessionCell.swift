//
//  SessionCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 08/01/2020.
//  Copyright © 2020 WinSoft. All rights reserved.
//

import UIKit

class SessionCell: UITableViewCell {

    @IBOutlet weak var lblSessionNum: UILabel!
    @IBOutlet weak var lblSessionName: UILabel!
    @IBOutlet weak var lblDateOfAppintment: UILabel!
    
    @IBOutlet weak var lblTiming: UILabel!
    
    @IBOutlet weak var lblCompleteOrNt: UILabel!
    
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblNoteDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
