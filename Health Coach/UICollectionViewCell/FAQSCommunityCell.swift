//
//  FAQSCommunityCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 03/09/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol CommunityAndLogoutDelegate : class {
//    func communitySelect(cell : FAQSCommunityCell )
    func logout(cell : FAQSCommunityCell )

}
class FAQSCommunityCell: UICollectionViewCell {
    
  weak   var delegate : CommunityAndLogoutDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    @IBAction func btnCommunityFAQ_Pressed(_ sender: UIButton) {
////        delegate?.communitySelect(cell: self)
//    }
    
    @IBAction func btnLogout_Pressed(_ sender: UIButton) {
        delegate?.logout(cell: self)

    }
}
