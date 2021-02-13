//
//  HydrationCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol isHydrationClickDelegate : class  {
    func isHydrateClick(cell : HydrationCell , index : IndexPath)
}
class HydrationCell: UICollectionViewCell {
    weak var delegate : isHydrationClickDelegate?
    var selectIndx  : IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction private func btnHydrateClick_Pressed(_ sender : UIButton) {
        delegate?.isHydrateClick(cell: self , index: selectIndx!)
    }
    
}
