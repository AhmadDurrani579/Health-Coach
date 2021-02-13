//
//  WAView.swift
//  WhereApp
//
//  Created by Salman on 30/05/2017.
//  Copyright © 2017 Salman. All rights reserved.
//

import UIKit

@IBDesignable class WAView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }

 }
