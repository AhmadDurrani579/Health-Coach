//
//  HeaderSectionCell.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 19/07/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

protocol IncrementOrDecrementDelegate : class {
    func incrementDate(cell : HeaderSectionCell , selectIndex : IndexPath  , sec : Int  , isFoodOrKitchen : Bool)
    func decrement(cell : HeaderSectionCell , selectIndex : IndexPath  , sec : Int ,  isFoodOrKitchen : Bool )
    func selectDate(cell : HeaderSectionCell , selectIndex : IndexPath , sec : Int , isFoodOrKitchen : Bool)
    func addItem(cell : HeaderSectionCell , index : IndexPath)

}

class HeaderSectionCell: UICollectionReusableView {

    @IBOutlet weak var lblTodayDate: UILabel!
    @IBOutlet weak var btnLeftArrow: UIButton!
    @IBOutlet weak var btnRightArrow: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgOfFoodDiaryOrKitchn: UIImageView!
    @IBOutlet weak var btnAddImage: UIButton!

    weak var delegate : IncrementOrDecrementDelegate?
    var indexSelect : IndexPath?
    var sectionSlect : Int?
    var selctItem : Bool?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction private func btnIncrement_Pressed(_ sender : UIButton) {
        delegate?.incrementDate(cell: self, selectIndex: indexSelect!, sec: sectionSlect! , isFoodOrKitchen: selctItem!)
        
    }
    
    @IBAction private func btnDecremen_Pressed(_ sender : UIButton) {
        delegate?.decrement(cell: self, selectIndex: indexSelect!, sec: sectionSlect! , isFoodOrKitchen:  selctItem!)
        
    }
    
    @IBAction private func btnSelectDate_Pressed(_ sender : UIButton) {
        delegate?.selectDate(cell: self, selectIndex: indexSelect! , sec: sectionSlect!, isFoodOrKitchen: selctItem!)
    }
    
    @IBAction private func btnAddItem(_ sender : UIButton){
        delegate?.addItem(cell: self, index: indexSelect!)
    }

    
}
