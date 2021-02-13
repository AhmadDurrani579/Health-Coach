//
//  FoodDiaryItemCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol DeleteFootItemDelegate  : class {
    func deleteFoodItem(cell : FoodDiaryItemCell , indexSeelect : IndexPath , section : Int)
}
class FoodDiaryItemCell: UICollectionViewCell {

    @IBOutlet weak var imgOfItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    weak var delegate : DeleteFootItemDelegate?
    var indexSelect : IndexPath?
    var section : Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnFoodItem(_ sender: UIButton) {
        delegate?.deleteFoodItem(cell: self, indexSeelect: self.indexSelect!  , section: section!)
        
    }
    
}
