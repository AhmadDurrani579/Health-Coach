//
//  CardCell.swift
//  VISH
//
//  Created by Ahmed Durrani on 24/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
@IBDesignable

class CardCell: UIView {

    @IBInspectable var cornerRadius: CGFloat = 20
    
    @IBInspectable var shadowOffsetWidth: Int = 3
    @IBInspectable var shadowOffsetHeight: Int = 5
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.4
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }

}
