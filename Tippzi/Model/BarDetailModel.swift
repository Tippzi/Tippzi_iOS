//
//  BarDetailModel.swift
//  Tippzi
//
//  Created by Admin on 11/28/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

struct BarDetailModel {
    
    var deal_name: String
    var deal_description : String
    var remain : String
    var duration : String
    var index: Int
    
    init(_ deal_name : String, _ deal_description : String, _ duration : String, _ remain : String,
         _ index : Int) {
        self.deal_name = deal_name
        self.deal_description = deal_description
        self.duration = duration
        self.remain = remain
        self.index = index
    }
}
