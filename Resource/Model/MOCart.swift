//
//  MOCart.swift
//  PFD
//
//  Created by Ahmed Durrani on 22/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class MOCart: NSObject {
    
    var id: Int?
    var menu_category_id: String?
    var menu_item_id    : String?
    var item_name: String?
    var descriptionOfMenu: String?
    var available: String?
    var price: String?
    var order_id : String?
    var quantity : String?
    var comment  : String?
    
//    {"menu_item_id": 10, "quantity": 1, "price": 250, "comment": "Comment here" }

    init(id: Int?,menu_category_id: String?,menu_item_id: String?,item_name: String? , descriptionOfMenu: String? , available: String?  , price :  String? , order_id : String? , quantity : String?  , comment : String?){
        self.id = id
        self.menu_category_id = menu_category_id
        self.menu_item_id = menu_item_id
        self.item_name = item_name
        self.descriptionOfMenu = descriptionOfMenu
        self.available = available
        self.price = price
        self.order_id = order_id
        self.quantity = quantity
        self.comment = comment
        
    }
}
