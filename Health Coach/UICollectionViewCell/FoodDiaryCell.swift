//
//  FoodDiaryCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol  FoodDiaryClickDelegate : class {
    func foodDiaryClck(cell : FoodDiaryCell , sect : Int , index : IndexPath)
}
class FoodDiaryCell: UICollectionViewCell {
    
   weak var delegate : FoodDiaryClickDelegate?
    var indexSelect : IndexPath?
    var sectionSelect : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction private func btnAddFoodIcon(_ sender : UIButton) {
        delegate?.foodDiaryClck(cell: self, sect: sectionSelect! , index: indexSelect!)
    }
}
