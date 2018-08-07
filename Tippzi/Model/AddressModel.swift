//
//  AddressModel.swift
//  Tippzi
//
//  Created by Admin on 11/9/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

import JSONJoy

struct AddressModel: JSONJoy {
    var latitude: Float?
    var longitude: Float?
    var addresses : [Addresses]
    
    init(_ decoder: JSONLoader) throws{
        latitude = try decoder["latitude"].get()
        longitude = try decoder["longitude"].get()
        guard let decoderArray = decoder["addresses"].getOptionalArray() else {throw JSONError.wrongType}
        addresses = [Addresses]()
        for decoderT in decoderArray{
            addresses.append(try Addresses(decoderT))
        }
    }
    
    init() {
        latitude = 0
        longitude = 0
        addresses = [Addresses]()
    }
}

struct Addresses: JSONJoy {
    var address: String?
    
    init(_ decoder: JSONLoader) throws{
        address = try decoder.get()
        address = Common.remove_comma(address!)
    }
    
    init() {
        address = ""
    }
}
