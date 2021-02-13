//
//  DashboardHeaderCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol ProfileInfoDelgate : class {
    func clickOnProfile(cell : DashboardHeaderCell , index : IndexPath)
}
class DashboardHeaderCell: UICollectionViewCell {

    @IBOutlet weak var lblHeaderName: UILabel!
    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblBMI: UILabel!
    @IBOutlet weak var lblMuscle: UILabel!
   weak var delegate : ProfileInfoDelgate?
    var indexSelect : IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        let cgFloat: CGFloat = imgOfUser.frame.size.width/2.0
//        let someFloat = Float(cgFloat)
//        WAShareHelper.setViewCornerRadius(imgOfUser, radius: CGFloat(someFloat))
        
    }

    @IBAction private func btnProfileDetail(_ sender : UIButton) {
        delegate?.clickOnProfile(cell: self, index: self.indexSelect!)
    }
}
