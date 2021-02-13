//
//  ExerciseFooterCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 20/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol  ExerciseDaiaryDelegate : class {
    func exerciseAdd(cell : ExerciseFooterCell ,  index : IndexPath)
    func viewMoreExercise(cell : ExerciseFooterCell ,  index : IndexPath)

}

class ExerciseFooterCell: UICollectionReusableView {
    weak var delegate : ExerciseDaiaryDelegate?
        var indexSelect : IndexPath?

    @IBOutlet weak var btnAddButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btnViewMore(_ sender: UIButton) {
        delegate?.viewMoreExercise(cell: self, index: indexSelect!)
    }
    
    @IBAction func btnAdd_Pressed(_ sender: UIButton) {
        delegate?.exerciseAdd(cell: self , index: indexSelect!)
    }
}
