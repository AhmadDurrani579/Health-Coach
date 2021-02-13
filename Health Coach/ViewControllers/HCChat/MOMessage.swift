//
//  MOMessage.swift
//  Health Coach
//
//  Created by Ahmed Durrani on 15/11/2019.
//  Copyright © 2019 WinSoft. All rights reserved.
//

import UIKit

struct MOMessage: Codable {
        var message: String?
        var userid : String?
        var fromid    : String?
    
    init( message :String, userid :String  , fromid : String){
      self.message  = message
      self.userid = userid
        self.fromid = fromid

    }

}

struct MessageList : Codable {
    var created_at : String?
    var fromed : Int?
    var name : String?
    var read_status : Int?
    var to : Int?
    var fromuserpicture : String?
    var message :   String?
    var username :   String?
    var type     :   Int?
    
    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case fromed = "fromed"
        case name = "name"
        case read_status = "read_status"
        case to = "to"
        case fromuserpicture = "touserpicture"
        case message = "message"
        case username = "username"
        case type = "type"


    }


}

//class MOMessage: NSObject {
//    var message: String?
//    var userid : String?
//    var fromid    : String?
//
//    init(message: String?,userid: String?,fromid: String?){
//        self.message = message
//        self.userid = userid
//        self.fromid = fromid
//    }
//}
