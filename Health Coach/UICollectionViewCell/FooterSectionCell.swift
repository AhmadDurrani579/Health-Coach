//
//  FooterSectionCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

//protocol AddFoodItemDelegate : class {
////    func addItem(cell : FooterSectionCell , index : IndexPath)
//}

class FooterSectionCell: UICollectionReusableView {

    @IBOutlet weak var btnViewMore: UIButton!
    
//    weak var delegate : AddFoodItemDelegate?
    var index : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction private func btnAddItem(_ sender : UIButton){
//        delegate?.addItem(cell: self, index: index!)
        
    }
}
