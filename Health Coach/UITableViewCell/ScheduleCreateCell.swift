//
//  ScheduleCreateCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 29/10/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol ScheduleDelegate : class {
    func createSchedule(cell : ScheduleCreateCell)
}
class ScheduleCreateCell: UITableViewCell {

    weak var delegate : ScheduleDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction private func btnCreateScheduleIt_Pressed(_ sender : UIButton) {
        delegate?.createSchedule(cell: self)
    }
    
}
