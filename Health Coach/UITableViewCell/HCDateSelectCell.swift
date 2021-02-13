//
//  HCDateSelectCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 20/11/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol SelectDateAndTimeDelegate : class {
    func selectTime(cell : HCDateSelectCell  , index : IndexPath)
//    func endTimeSelect(cell : HCDateSelectCell)
}
class HCDateSelectCell: UITableViewCell {
    
    weak var delegate : SelectDateAndTimeDelegate?
    
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var btnTime: UIButton!

    @IBOutlet weak var viewOfBG: CardView!
    var indexSelect : IndexPath?
//    @IBOutlet weak var btnStartDate: UIButton!
//    @IBOutlet weak var btnEndDateE: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSelectTime(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        delegate?.selectTime(cell: self, index: indexSelect!)
    }
    
    
//    @IBAction func btnStartTime_Pressed(_ sender: UIButton) {
//        delegate?.selectStartTime(cell: self)
//    }
//    @IBAction func btnEndTime_Pressed(_ sender: UIButton) {
//        delegate?.endTimeSelect(cell: self)
//    }
}
