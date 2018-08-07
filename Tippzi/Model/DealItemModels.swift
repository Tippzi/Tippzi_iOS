//
//  DealItemModels.swift
//  Tippzi
//
//  Created by Admin on 11/13/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation


struct DealItemModels {
    var index: Int = 0
    var title: String
    var description : String
    var days_duration : String
    var impressions : String
    var in_wallet : String
    var claimed : String
    
    init(_ title: String, _ description : String, _ days_duration : String,
         _ impressions : String, _ in_wallet : String, _ claimed : String, _ index : Int) {
        self.title = title
        self.description = description
        self.days_duration = days_duration
        self.impressions = impressions
        self.in_wallet = in_wallet
        self.claimed = claimed
        self.index = index
    }
}
