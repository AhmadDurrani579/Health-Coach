//
//  MOCheckOut.swift
//  PFD
//
//  Created by Ahmed Durrani on 07/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class MOCheckOut: NSObject {
    
    var menu_item_id    : String?
    var quantity: String?
    var price: String?
    var comment : String?
  
    init(menu_item_id: String?,quantity: String?,price: String? , comment: String? ) {
        self.menu_item_id = menu_item_id
        self.quantity = quantity
        self.price = price
        self.comment = comment

    }

}
