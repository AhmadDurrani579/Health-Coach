//
//  ExerciseCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol  ExerciseClickDelegate : class {
    func exerciseDiaryClick(cell : ExerciseCell , sect : Int , index : IndexPath)
}

class ExerciseCell: UICollectionViewCell {
    
    weak var delegate : ExerciseClickDelegate?
    var index : IndexPath?
    var sectionSelect : Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction private func  btnExercise(_ sender : UIButton) {
        delegate?.exerciseDiaryClick(cell: self, sect: sectionSelect! , index: index!)
    }
    

}
