//
//  BusinessSignUpModel.swift
//  Tippzi
//
//  Created by Admin on 11/9/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

struct BusinessSignUpModel {
    var username: String?
    var email : String?
    var telephone : String?
    var password : String?
    var business_name : String?
    var category_name : String?
    var post_code : String?
    var address : String
    var lat : String?
    var lon : String?
    var social_account : Int?
    var flag : Bool?
    var service_name: String?
    
    init(){
        username = ""
        email = ""
        telephone = ""
        password = ""
        business_name = ""
        category_name = ""
        post_code = ""
        address = ""
        lat = ""
        lon = ""
        social_account = 0
        flag = false
        service_name = ""
    }
}
