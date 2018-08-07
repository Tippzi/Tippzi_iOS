//
//  MapDataFetch.swift
//  Tippzi
//
//  Created by Admin on 2/14/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
import SwiftHTTP
import JSONJoy
import CoreLocation

class MapDataFetch {
    var timer:Timer = Timer()
    var flag:Bool = false
    var rate : CGFloat = 0
    var select_category : String = ""
    var table_width : CGFloat = 0
    var category_image_width : CGFloat = 1280
    var category_image_height : CGFloat = 800
    /**/
    var previous = NSDecimalNumber.one
    var current = NSDecimalNumber.one
    var position: UInt = 1
    var updateTimer: Timer?
    
    let defaults = UserDefaults.standard
    
    func startFetchData(){
        updateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                           selector: #selector(calculateNextNumber), userInfo: nil, repeats: true)
    }
    func stopTask(){
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    
    @objc func calculateNextNumber() {
        LoadCall()
    }
    
    func LoadCall(){
        let user_type = defaults.string(forKey: "user_type")
        if user_type == "1" {
            showViewController1()
        }
    }
    
    @objc func finishedResponse1() { //customer
        // timer
        if self.flag == false {
            return
        }
        
        timer.invalidate()
        
        Common.selectcategory = [LocationModel]()
        var category_deal = [SelectCategoryDeal]()
        
        for i in 0 ..< Common.customerModel.bars.count {
            if Common.category_name == Common.customerModel.bars[i].category {
                var bar_id = Common.customerModel.bars[i].bar_id
                var barTitle = Common.customerModel.bars[i].business_name
                var music_type = Common.customerModel.bars[i].music_type
                var latitude = CLLocationDegrees(Common.customerModel.bars[i].lat!)
                var longitude = CLLocationDegrees(Common.customerModel.bars[i].lon!)
                var address = Common.customerModel.bars[i].address
                var service_name = Common.customerModel.bars[i].service_name
                
                var category_deal = [SelectCategoryDeal]()
                var remain_number : Int = 0
                for j in 0 ..< Common.customerModel.bars[i].deal.count {
                    
                    var deal_title = Common.customerModel.bars[i].deal[j].title
                    var deal_description = Common.customerModel.bars[i].deal[j].description
                    remain_number = Int(Common.customerModel.bars[i].deal[j].qty!)! - Int(Common.customerModel.bars[i].deal[j].claimed!)!
                    var remain = String(remain_number) + " left Exp " + Common.customerModel.bars[i].deal[j].duration!
                    
                    category_deal += [SelectCategoryDeal(deal_title: deal_title!, deal_description: deal_description!, remain: remain)]
                }
                
                var barImage : String = ""
                if !(Common.customerModel.bars[i].background1?.isEmpty)! {
                    barImage = Common.download + Common.customerModel.bars[i].background1!
                } else if (!(Common.customerModel.bars[i].background2?.isEmpty)!) {
                    barImage = Common.download + Common.customerModel.bars[i].background2!
                } else if (!(Common.customerModel.bars[i].background3?.isEmpty)!) {
                    barImage = Common.download + Common.customerModel.bars[i].background3!
                } else if (!(Common.customerModel.bars[i].background4?.isEmpty)!) {
                    barImage = Common.download + Common.customerModel.bars[i].background4!
                } else if (!(Common.customerModel.bars[i].background5?.isEmpty)!) {
                    barImage = Common.download + Common.customerModel.bars[i].background5!
                } else if (!(Common.customerModel.bars[i].background6?.isEmpty)!) {
                    barImage = Common.download + Common.customerModel.bars[i].background6!
                }
                
                Common.selectcategory += [LocationModel(index_num: Int(bar_id!)!, latitude: latitude!, longitude: longitude!,  selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle!, music_type: music_type!, category_name: Common.category_name, address: address!, service_name: service_name!)]
            }
        }
    }
    
    func showViewController1() {
        
        let user_id = defaults.string(forKey: "user_id")
        
        // if customer
        let lan = String(Common.Coordinate.latitude)
        let lon = String(Common.Coordinate.longitude)
        
        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse1), userInfo: nil, repeats: true)
        
        // HTTP request
        let url = Common.api_location + "check_remember_customer.php"
        let params = ["user_id": user_id,
                      "lat": lan,
                      "lon": lon]
        do {
            let opt = try HTTP.POST(url, parameters: params)
            opt?.run { response in
                if let error = response.error {
                    
                    DispatchQueue.main.sync(execute: {
                        //MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                        
                        // stop timer
                        self.timer.invalidate()
                        return
                    })
                    
                }
                do {
                    Common.customerModel = try CustomerModel(JSONLoader(response.text!))
                    if Common.customerModel.success == "true" {
                        self.defaults.set(Common.customerModel.user_type, forKey: "user_type")
                        self.defaults.set(Common.customerModel.user_id, forKey: "user_id")
                        self.flag = true
                    }else {
                        
                        DispatchQueue.main.sync(execute: {
                            self.timer.invalidate()
                            return
                        })
                    }
                    
                } catch {
                    //Toast.toast("Json string error: \(error)")
                }
            }
        } catch let error {
            //Toast.toast("Request error: \(error)")
        }
    }
    
}
