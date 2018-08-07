//
//  MainData.swift
//  Buc
//
//  Created by Admin on 3/15/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import JSONJoy

struct BusinessModel: JSONJoy {
    
    var bars: [Bars]
    
    var success: String?
    var message: String?
    var user_id: String?
    var username: String?
    var email: String?
    var telephone: String?
    var user_type: String?
    
    init(_ decoder: JSONLoader) throws{
        // bars array decoderArray
        
        success = try decoder["success"].get()
        message = try decoder["message"].get()
        user_id = try decoder["user_id"].get()
        username = try decoder["username"].get()
        email = try decoder["email"].get()
        telephone = try decoder["telephone"].get()
        user_type = try decoder["user_type"].get()
        
        guard let decoderArray = decoder["bars"].getOptionalArray() else {throw JSONError.wrongType}
        bars = [Bars]()
        for decoderT in decoderArray{
            bars.append(try Bars(decoderT))
        }
        
    }
    
    init() {
        
        bars = [Bars]()
        
        success = ""
        message = ""
        user_id = ""
        username = ""
        email = ""
        telephone = ""
        user_type = ""
        
    }
    
}

struct Bars: JSONJoy {
    var openHour : OpenHour?
    var bargallery : Gallery?
    var deal : [Deals]
    
    var bar_id: String?
    var business_name: String?
    var category: String?
    var post_code: String?
    var address: String?
    var telephone: String?
    var website: String?
    var email : String?
    var description: String?
    var music_type: String?
    var lat: String?
    var lon: String?
    var service_name: String?
    
    var sat_end: String?
    var sun_start : String?
    var tue_start : String?
    var fri_start : String?
    var thur_end : String?
    var tue_end : String?
    var fri_end : String?
    var mon_start : String?
    var wed_start : String?
    var sun_end : String?
    var thur_start: String?
    var mon_end : String?
    var sat_start : String?
    var wed_end : String?
    
    var background1 : String?
    var background2 : String?
    var background3 : String?
    var background4 : String?
    var background5 : String?
    var background6 : String?
    
    var background1_height : String?
    var background2_height : String?
    var background3_height : String?
    var background4_height : String?
    var background5_height : String?
    var background6_height : String?
    
    init(_ decoder: JSONLoader) throws{
        
        bar_id = try decoder["bar_id"].get()
        business_name = try decoder["business_name"].get()
        category = try decoder["category"].get()
        post_code = try decoder["post_code"].get()
        address = try decoder["address"].get()
        telephone = try decoder["telephone"].get()
        website = try decoder["website"].get()
        email = try decoder["email"].get()
        description = try decoder["description"].get()
        music_type = try decoder["music_type"].get()
        lat = try decoder["lat"].get()
        lon = try decoder["lon"].get()
        service_name = try decoder["service_name"].get()
        
        sat_end =  try decoder["open_time"]["sat_end"].get()
        sun_start = try decoder["open_time"]["sun_start"].get()
        tue_start = try decoder["open_time"]["tue_start"].get()
        fri_start = try decoder["open_time"]["fri_start"].get()
        thur_end = try decoder["open_time"]["thur_end"].get()
        tue_end = try decoder["open_time"]["tue_end"].get()
        fri_end = try decoder["open_time"]["fri_end"].get()
        mon_start = try decoder["open_time"]["mon_start"].get()
        wed_start = try decoder["open_time"]["wed_start"].get()
        sun_end = try decoder["open_time"]["sun_end"].get()
        thur_start =  try decoder["open_time"]["thur_start"].get()
        mon_end = try decoder["open_time"]["mon_end"].get()
        sat_start = try decoder["open_time"]["sat_start"].get()
        wed_end = try decoder["open_time"]["wed_end"].get()
        openHour  = OpenHour(mon_start!,mon_end!,tue_start!,tue_end!,wed_start!,wed_end!,
                                  thur_start!,thur_end!,fri_start!,fri_end!, sat_start!,sat_end!, sun_start!, sun_end!)
        
        background1 =  try decoder["gallery"]["background1"].get()
        background2 =  try decoder["gallery"]["background2"].get()
        background3 =  try decoder["gallery"]["background3"].get()
        background4 =  try decoder["gallery"]["background4"].get()
        background5 =  try decoder["gallery"]["background5"].get()
        background6 =  try decoder["gallery"]["background6"].get()
        
        background1_height =  try decoder["gallery"]["height1"].get()
        background2_height =  try decoder["gallery"]["height2"].get()
        background3_height =  try decoder["gallery"]["height3"].get()
        background4_height =  try decoder["gallery"]["height4"].get()
        background5_height =  try decoder["gallery"]["height5"].get()
        background6_height =  try decoder["gallery"]["height6"].get()
        
        bargallery = Gallery(background1: background1!, background2: background2!,background3: background3!,background4: background4!,background5: background5!,background6: background6!,background1_height: background1_height!,background2_height: background2_height!,background3_height: background3_height!, background4_height: background4_height!,background5_height: background5_height!,background6_height: background6_height!)
        
        guard let decoderArray = decoder["deals"].getOptionalArray() else {throw JSONError.wrongType}
        deal = [Deals]()
        if decoderArray.count != 0 {
            for decoderT in decoderArray{
                deal.append(try Deals(decoderT))
            }
        }
    }
    
    init() {
        bar_id = ""
        business_name = ""
        category = ""
        post_code = ""
        address = ""
        telephone = ""
        website = ""
        email = ""
        description = ""
        music_type = ""
        lat = ""
        lon = ""
        service_name = ""
        
        deal = [Deals]()
    }
    
}

struct OpenHour {
    var mon_start: String?
    var mon_end: String?
    var tue_start: String?
    var tue_end: String?
    var wed_start: String?
    var wed_end: String?
    var thur_start: String?
    var thur_end: String?
    var fri_start: String?
    var fri_end: String
    var sat_start: String?
    var sat_end: String?
    var sun_start: String?
    var sun_end: String?
    
    init(_ mon_start: String, _ mon_end: String,_ tue_start: String,_ tue_end: String,_ wed_start: String,_ wed_end: String,_ thur_start: String,_ thur_end: String,_ fri_start: String, _ fri_end: String, _ sat_start: String, _ sat_end: String, _ sun_start: String, _ sun_end: String) {
        self.mon_start = mon_start
        self.mon_end = mon_end
        self.tue_start = tue_start
        self.tue_end = tue_end
        self.wed_start = wed_start
        self.wed_end = wed_end
        self.thur_start = thur_start
        self.thur_end = thur_end
        self.fri_start = fri_start
        self.fri_end = fri_end
        self.sat_start = sat_start
        self.sat_end = sat_end
        self.sun_start = sun_start
        self.sun_end = sun_end
        
    }
    
    init() {
        mon_start = ""
        mon_end = ""
        tue_start = ""
        tue_end = ""
        wed_start = ""
        wed_end = ""
        thur_start = ""
        thur_end = ""
        fri_start = ""
        fri_end = ""
        sat_start = ""
        sat_end = ""
        sun_start = ""
        sun_end = ""
    }

}

struct Gallery {
    
    var background1: String?
    var background2: String?
    var background3: String?
    var background4: String?
    var background5: String?
    var background6: String?
    
    var background1_height: String?
    var background2_height: String?
    var background3_height: String?
    var background4_height: String?
    var background5_height: String?
    var background6_height: String?
    
    init(background1: String,  background2: String, background3: String, background4: String, background5: String, background6: String, background1_height: String,  background2_height: String, background3_height: String, background4_height: String, background5_height: String, background6_height: String) {
        self.background1 = background1
        self.background2 = background2
        self.background3 = background3
        self.background4 = background4
        self.background5 = background5
        self.background6 = background6
        
        self.background1_height = background1_height
        self.background2_height = background2_height
        self.background3_height = background3_height
        self.background4_height = background4_height
        self.background5_height = background5_height
        self.background6_height = background6_height
    }
    
    init() {
        background1 = ""
        background2 = ""
        background3 = ""
        background4 = ""
        background5 = ""
        background6 = ""
        
        background1_height = ""
        background2_height = ""
        background3_height = ""
        background4_height = ""
        background5_height = ""
        background6_height = ""
    }
    
}

struct Deals: JSONJoy {
    
    var deal_days : Deal_Days?
    
    var deal_id: String?
    var title: String?
    var description: String?
    var duration: String?
    var qty: String?
    var in_wallet: String?
    var impressions : String?
    var claimed: String?
    var engagement: String?
    var clicks: String?
    
    var monday : String?
    var tuesday : String?
    var wednesday : String?
    var thursday : String?
    var friday : String?
    var saturday : String?
    var sunday : String?
    
    
    init(_ decoder: JSONLoader) throws{
        deal_id = try decoder["deal_id"].get()
        title = try decoder["title"].get()
        description = try decoder["description"].get()
        duration = try decoder["duration"].get()
        qty = try decoder["qty"].get()
        in_wallet = try decoder["in_wallet"].get()
        impressions = try decoder["impressions"].get()
        claimed = try decoder["claimed"].get()
        engagement = try decoder["engagement"].get()
        clicks = try decoder["clicks"].get()
        
        monday =  try decoder["deal_days"]["monday"].get()
        tuesday = try decoder["deal_days"]["tuesday"].get()
        wednesday = try decoder["deal_days"]["wednesday"].get()
        thursday = try decoder["deal_days"]["thursday"].get()
        friday = try decoder["deal_days"]["friday"].get()
        saturday = try decoder["deal_days"]["saturday"].get()
        sunday = try decoder["deal_days"]["sunday"].get()
        deal_days  = Deal_Days(monday!,tuesday!,wednesday!,thursday!,friday!,saturday!,sunday!)
    }
    
    init() {
        
        deal_days = Deal_Days("","","","","","","")
        
        deal_id = ""
        title = ""
        description = ""
        duration = ""
        qty = ""
        in_wallet = ""
        impressions = ""
        claimed = ""
        engagement = ""
        clicks = ""
    }
    
}

struct Deal_Days {
    
    var monday: String?
    var tuesday: String?
    var wednesday: String?
    var thursday: String?
    var friday: String?
    var saturday: String?
    var sunday: String?
    
    init(_ monday: String, _ tuesday: String,_ wednesday: String,_ thursday: String,_ friday: String,_ saturday: String, _ sunday: String) {
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
    }
    
        
}






