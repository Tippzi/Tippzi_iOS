//
//  BuDealDetailModel.swift
//  Tippzi
//
//  Created by Admin on 1/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

struct BuDealDetailModel {
    
    var deal_name: String
    var deal_description : String
    var index: Int
    
    init(_ deal_name : String, _ deal_description : String, _ index : Int) {
        self.deal_name = deal_name
        self.deal_description = deal_description
        self.index = index
    }
}
