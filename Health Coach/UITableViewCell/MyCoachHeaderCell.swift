//
//  MyCoachHeaderCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 20/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol SubscriptionDelegate : class {
    func subscription(cell : MyCoachHeaderCell)
}

class MyCoachHeaderCell: UITableViewCell {
    
    @IBOutlet weak var viewOfInfo: CardView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var imgOfCoach: UIImageView!
    
    @IBOutlet weak var lblCoachName: UILabel!
    
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var btnSubsCription: UIButton!

    weak var delegate : SubscriptionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction private func btnSubscription_Pressed(_ sender : UIButton) {
        delegate?.subscription(cell: self)
    }
    
}
