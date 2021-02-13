//
//  MOMessageItemList.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 17/11/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

class MOMessageItemList: NSObject {
    var created_at : String?
    var fromed : Int?
    var name : String?
    var read_status : Int?
    var to : Int?
    var type : Int?

    init(created_at: String?,fromed: Int?,name: String?,read_status: Int? , to: Int? , type : Int?){
       
        self.created_at = created_at
        self.fromed = fromed
        self.name = name
        self.read_status = read_status
        self.to = to
        self.type = type
    }
        
}
