//
//  HydrationSelectCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 24/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol BottleSelectDelegate : class {
    func bottleSelect(cell : HydrationSelectCell , selectBottle : Int , index : IndexPath , isButtonSelect : Bool)
}

class HydrationSelectCell: UICollectionViewCell {

    @IBOutlet weak var bottle1: UIImageView!
    @IBOutlet weak var bottle2: UIImageView!
    @IBOutlet weak var bottle3: UIImageView!
    @IBOutlet weak var bottle4: UIImageView!
    @IBOutlet weak var bottle5: UIImageView!
    @IBOutlet weak var bottle6 : UIImageView!

    weak var delegate : BottleSelectDelegate?
    var selectIndex : IndexPath?
    var selectWaterBottle : Int?
    var btnSelect : Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction private func btnBottleSelect_Pressed(_ sender : UIButton) {
        if sender.isSelected == true {
            delegate?.bottleSelect(cell: self, selectBottle: sender.tag , index: selectIndex!, isButtonSelect: true)
        } else {
            delegate?.bottleSelect(cell: self, selectBottle: sender.tag , index: selectIndex!, isButtonSelect: false)

        }
    }

}
