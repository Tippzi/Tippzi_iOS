//
//  Common.swift
//  Tippzi
//
//  Created by Admin on 11/10/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import Foundation
import JSONJoy
import CoreLocation

class Common {
    
    //--------------------------- Global variables -----------------------//
//    // Api location
    static let host = "http://162.13.192.72/"
//    static let host = "http://192.168.1.102/"
    static let api_location = host + "Tippzi/api/authorize/"
    static let download = host + "Tippzi/upload/"
    
    static var lookup_button_flag = 0
    
    static var businessDash_index : Int = 0
    static var toTicketfordeal_index : Int = 0
    static var check_wallet: Bool = false
    
    static var selectAddress : String = ""
    static var manually_flag : Bool = false
    
    static var select_open = ""
    static var select_time = ""
    static var select_dealtitle_descrip = ""
    static var slide_index = 0
    static var select_date1 : Int = 0
    static var select_date2 : Int = 0
    static var inDash_delete_index : Int = 0
    static var inWallet_delete_index : Int = 0
    static var search_switch_flag : Int = 0
    static var select_category = ""
    
    static var select_pos : Int = 0
    static var wallet_pos : Int = 0
    static var select_flag = false
    static var from_claimdeal : Bool = false
    static var temp_walletModel = Temp_walletModel()
    static var fromBarDetail_toMap_flag : Bool = false
    static var fromBarDetail_toRoute_flag : Bool = false
    static var fromTicket_toRoute_flag : Bool = false
    
    static var gender = ""
    static var category = "" // use in business part
    
    static var webUrl = ""
    static var isAccepted = true
    
    //google map
    static var select_page_in : Int = 0
    static var search_string : String = ""
    static var flagOfMapViewFromCategory : Bool = false
    static var category_name : String = "" // use in customer part
    static var select_barid : Int = 0
    // constant variables
    //-----Business
    static var addressModel = AddressModel()
    static var businessModel = BusinessModel()
    static var businessSignUpModel = BusinessSignUpModel()
    static var customerSignUpModel = CustomerSignUpModel()
    static var dealModel = DealModel()
    static var openhourModel = OpenHourModel()
    static var galleryModel = GalleryModel()
    static var editBarModel = EditBarModel()
    static var fontsizeModel = [Font]()
    static var selectcategory = [LocationModel]()
    static var Coordinate = CLLocationCoordinate2D()
    //-----Customer
    static var customerModel = CustomerModel()
    static var imageSize = [ImageSize]()
    //check device version
    static var deviceVersion : String  = ""
    static var kClientId : String = "295397127329-nunsn725egal2ee1gfq1qsujbs1njlg7.apps.googleusercontent.com";
    
    //--------------------------- Global functions -----------------------//
    // Trim string
    class func trim(_ str: String) -> String {
        let trimmedStr = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedStr
    }
    
    // New line
    class func newLine() -> String {
        return "\r\n"
    }
    
    class func getDate(_ datetime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: datetime)
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
    
    // change text color
    class func change_text_dark_color(_ str : UITextField)
    {
        if !((str.text?.isEmpty)!) {
            
            str.textColor = UIColor.black
        }
    }
    
    // change text color
    class func change_text_dark_color(_ str : UITextView)
    {
        if !((str.text?.isEmpty)!) {
            str.textColor = UIColor.black
        }
    }
    
    class func remove_comma(_ str : String) -> String {
        
        var string = str.replacingOccurrences(of: ", ", with: " ")
        string = string.replacingOccurrences(of: "     ", with: ", ")
        return string
        
    }
    
}

extension String {
    func indexOf(_ target: String) -> Int? {
        if let range = self.range(of: target) {
            return characters.distance(from: startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    
    func lastIndexOf(_ target: String) -> Int? {
        if let range = self.range(of: target, options: .backwards) {
            return characters.distance(from: startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
}

extension UIView {
    func setViewBorderStyle(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        if (cornerRadius > 0) {
            self.layer.cornerRadius = cornerRadius
        }
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
