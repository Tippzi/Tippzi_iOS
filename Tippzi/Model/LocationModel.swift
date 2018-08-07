//
//  LocationModel.swift
//  Tippzi
//
//  Created by Admin on 11/23/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

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
