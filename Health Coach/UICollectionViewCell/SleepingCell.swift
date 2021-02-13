//
//  SleepingCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit
protocol AddSleepDelegate : class {
    func addSleepTime(cell : SleepingCell , selectIndex : IndexPath )
}

class SleepingCell: UICollectionViewCell {
    
    weak var delegate : AddSleepDelegate?
    var selectIndex : IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnAddSleep(_ sender: UIButton) {
        delegate?.addSleepTime(cell: self, selectIndex: selectIndex!)
        
    }
}
