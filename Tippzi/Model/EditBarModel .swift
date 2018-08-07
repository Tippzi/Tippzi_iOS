//
//  EditBarModel .swift
//  Tippzi
//
//  Created by Admin on 11/12/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

struct EditBarModel {
        
    var bar_id : String = ""
    var business_name : String = ""
    var category_name : String = ""
    var post_code : String = ""
    var address : String = ""
    var lat : String = ""
    var lon : String = ""
    var telephone : String = ""
    var website : String = ""
    var email : String  = ""
    var description : String = ""
    var music_type  : String = ""
    var textview_lines : Int = 0
    var category_flag : Bool = false
    var editopenHour :  EditOpenHourModel?
    var galleryModel : EditGalleryModel?
    var service_name: String = ""
    
    init(){
       
        editopenHour  = EditOpenHourModel()
        
        galleryModel = EditGalleryModel()
    }
}

struct EditOpenHourModel {
    var mon_start: String?
    var mon_end: String?
    var tue_start: String?
    var tue_end: String?
    var wed_start: String?
    var wed_end: String?
    var thur_start: String?
    var thur_end: String?
    var fri_start: String?
    var fri_end: String?
    var sat_start: String?
    var sat_end: String?
    var sun_start: String?
    var sun_end: String?
    
    var mon_start1: String?
    var mon_end1: String?
    var tue_start1: String?
    var tue_end1: String?
    var wed_start1: String?
    var wed_end1: String?
    var thur_start1: String?
    var thur_end1: String?
    var fri_start1: String?
    var fri_end1: String?
    var sat_start1: String?
    var sat_end1: String?
    var sun_start1: String?
    var sun_end1: String?
    
    init() {
        self.mon_start = ""
        self.mon_end = ""
        self.tue_start = ""
        self.tue_end = ""
        self.wed_start = ""
        self.wed_end = ""
        self.thur_start = ""
        self.thur_end = ""
        self.fri_start = ""
        self.fri_end = ""
        self.sat_start = ""
        self.sat_end = ""
        self.sun_start = ""
        self.sun_end = ""
        
        self.mon_start1 = ""
        self.mon_end1 = ""
        self.tue_start1 = ""
        self.tue_end1 = ""
        self.wed_start1 = ""
        self.wed_end1 = ""
        self.thur_start1 = ""
        self.thur_end1 = ""
        self.fri_start1 = ""
        self.fri_end1 = ""
        self.sat_start1 = ""
        self.sat_end1 = ""
        self.sun_start1 = ""
        self.sun_end1 = ""
    }
}

struct EditGalleryModel {
    var background1 : String = ""
    var background2 : String = ""
    var background3 : String = ""
    var background4 : String = ""
    var background5 : String = ""
    var background6 : String = ""
    
    init(){
        background1 = ""
        background2 = ""
        background3 = ""
        background4 = ""
        background5 = ""
        background6 = ""
    }
}
			
