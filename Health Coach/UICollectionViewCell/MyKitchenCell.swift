//
//  MyKitchenCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol AddKitchenItemDelegate : class {
    func addKitchen(cell : MyKitchenCell , index : IndexPath)
}

class MyKitchenCell: UICollectionViewCell {
    
    weak var delegate : AddKitchenItemDelegate?
    var index : IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    @IBAction func btnAddKitchec(_ sender: UIButton) {
        delegate?.addKitchen(cell: self, index: index!)

    }
}
