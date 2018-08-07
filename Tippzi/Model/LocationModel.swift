//
//  LocationModel.swift
//  Tippzi
//
//  Created by Admin on 11/23/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import JSONJoy

struct LocationModel {
    var index_num : Int = 0
    var latitude: Double = 0
    var longitude: Double = 0
    var selectcategory_deal = [SelectCategoryDeal]()
    var barImage : String = ""
    var barTitle : String = ""
    var music_type : String = ""
    var category_name : String = ""
    var address : String = ""
    var service_name: String = ""
}

struct SelectCategoryDeal {
    var deal_title : String = ""
    var deal_description : String = ""
    var remain : String = ""
}

struct SearchModel {
    var is_bar_name : Bool = false
    var name : String = ""
}

struct TippziCoinModel {
    var id: Int = 0
    var latitude: String = "0"
    var longitude: String = "0"
    var group: String = "0"
    var token: String = ""
    var status: Int = 0
    
    init(_ decoder: JSONLoader) throws {
        print(decoder)
        id = try decoder["id"].get()
        latitude = try decoder["latitude"].get()
        longitude = try decoder["longitude"].get()
        group = try decoder["group"].get()
        token = try decoder["token"].get()
        status = try decoder["status"].get()
    }
}
