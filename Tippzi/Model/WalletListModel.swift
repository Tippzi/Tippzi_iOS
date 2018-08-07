//
//  DealItemModel1.swift
//  Tippzi
//
//  Created by Admin on 11/21/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

struct WalletListModel {

    var bar_id: String
    var deal_id: String
    var deal_title: String
    var deal_description: String
    var deal_duratioin: String
    var deal_qty: String
    var impressions: String
    var in_wallet: String
    var claimed: String
    var business_name : String
    var music_type : String
    var index: Int

    init(_ bar_id : String, _ deal_id : String, _ deal_title : String, _ deal_description : String, _ deal_duratioin : String,
         _ deal_qty : String, _ impressions : String, _ in_wallet : String, _ claimed : String, _ business_name : String,
         _ music_type : String, _ index : Int) {
        
        self.bar_id = bar_id
        self.deal_id = deal_id
        self.deal_title = deal_title
        self.deal_description = deal_description
        self.deal_duratioin = deal_duratioin
        self.deal_qty = deal_qty
        self.impressions = impressions
        self.in_wallet = in_wallet
        self.claimed = claimed
        self.business_name = business_name
        self.music_type = music_type
        self.index = index
        
    }
    
}
