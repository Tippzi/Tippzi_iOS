//
//  CustomerSignUpModel.swift
//  Tippzi
//
//  Created by Admin on 12/25/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

struct CustomerSignUpModel {
    var username: String?
    var email : String?
    var gender : String?
    var nickname : String?
    var password : String?
    var confirm_password : String?
    var flag : Bool?
    
    init(){
        username = ""
        email = ""
        gender = ""
        nickname = ""
        password = ""
        confirm_password = ""
        flag = false
    }
}
