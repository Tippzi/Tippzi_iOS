    //
//  ClaimAlertViewController.swift
//  Tippzi
//
//  Created by Admin on 11/28/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy
import CoreLocation

class ClaimAlertViewController: UIViewController {

    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    @IBOutlet weak var claimalertLabel: UILabel!
    
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    var deal_id: String = ""
    var select_pos : Int = 0
    var check_bar : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        //font size set
        claimalertLabel.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        btnYes.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        btnNo.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))

        //
        myView.layer.cornerRadius = 15
        myView.layer.borderColor = UIColor.white.cgColor
        myView.layer.borderWidth = 2
        btnYes.layer.cornerRadius = btnYes.frame.height / 2
        btnYes.layer.borderColor = UIColor.white.cgColor
        btnYes.layer.borderWidth = 2
        btnNo.layer.cornerRadius = btnNo.frame.height / 2
        btnNo.layer.borderColor = UIColor.white.cgColor
        btnNo.layer.borderWidth = 2
        
        self.activeIndicator.isHidden = true
        
        for i in 0...Common.customerModel.bars.count-1{
            if Int(Common.customerModel.bars[i].bar_id!) == Common.select_barid {
                select_pos = i
            }
        }
        
    }
    
    @IBAction func btnYesClick(_ sender: Any) {
        
        Claim_Deal()
        
    }
    
    @IBAction func btnNoClick(_ sender: Any) {
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @objc func finishedResponse() {
        // timer
        if self.flag == false {
            return
        }
        
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        Common.from_claimdeal = true
        Common.temp_walletModel.claimed_check = "true"
        
        Common.selectcategory = [LocationModel]()
        var category_deal = [SelectCategoryDeal]()
        for i in 0 ..< Common.customerModel.bars.count {
            let select_category = Common.category_name
            if select_category == Common.customerModel.bars[i].category {
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
                    var remain = String(remain_number) + " remaining Exp " + Common.customerModel.bars[i].deal[j].duration!
                    
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
                
                Common.selectcategory += [LocationModel(index_num: Int(bar_id!)!, latitude: latitude!, longitude: longitude!,  selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle!, music_type: music_type!, category_name: select_category, address: address!, service_name:service_name!)]

            }
        }
        for i in 0 ..< Common.customerModel.bars.count {
            if Int(Common.customerModel.bars[i].bar_id!) == Common.select_barid {
                //transition effect
                check_bar = true
                break;
            }
        }
        if check_bar == true {
            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")
            let transition = CATransition()
            transition.type =  kCATransitionFromBottom
            transition.subtype = kCATransitionFromBottom
            transition.duration = 0.2
            view.window!.layer.add(transition, forKey: kCATransition)
            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(toViewController!, animated: true, completion:nil)
        } else {
            if (Common.check_wallet == true) {
                //transition effect
                let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddWalletView")
                let transition = CATransition()
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromRight
                transition.duration = 0.5
                view.window!.layer.add(transition, forKey: kCATransition)
                toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                self.present(toViewController!, animated: true, completion:nil)
                
            } else {
                Common.select_barid = Int(Common.customerModel.bars[0].bar_id!)!
                //transition effect
                let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomerBarDetailViewController")
                let transition = CATransition()
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromLeft
                transition.duration = 0.5
                view.window!.layer.add(transition, forKey: kCATransition)
                toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                self.present(toViewController!, animated: true, completion:nil)
                
                
            }
        }
    }
    
    func Claim_Deal() {

        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)

        let latitude = String(Common.Coordinate.latitude)
        let longitude = String(Common.Coordinate.longitude)
        var user_id = Common.customerModel.user_id

        if (Common.check_wallet == true) {

            self.deal_id = Common.customerModel.wallets[Common.wallet_pos].deal_id!

        } else {

            self.deal_id = Common.customerModel.bars[select_pos].deal[Common.toTicketfordeal_index].deal_id!

        }

        var deal_id = self.deal_id
        var lat = latitude
        var lon = longitude

        //create the url with URL
        let url = URL(string:Common.api_location + "add_claim.php")!

        let params = ["user_id": user_id, "deal_id": deal_id, "lat": lat, "lon": lon] as [String : Any]

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body

        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        self.activeIndicator.isHidden = false
        self.activeIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                DispatchQueue.main.sync(execute: {

                    self.view.isUserInteractionEnabled = true
                    
                    MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")

                    // stop timer
                    self.activeIndicator.stopAnimating()
                    self.activeIndicator.isHidden = true
                    self.timer.invalidate()
                 })
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    // handle json...
                    print(json)
                    Common.customerModel = try CustomerModel(JSONLoader(json))
                    if Common.customerModel.success == "true" {
                        self.flag = true
                        
                    }else {
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: Common.customerModel.message!)
                            
                            // stop timer
                            self.activeIndicator.stopAnimating()
                            self.activeIndicator.isHidden = true
                            self.timer.invalidate()
                            
                            return
                        })
                    }
                    
                }

            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()

    }
    
//    func Claim_Deal() {
//
//        self.flag = false
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
//
//        let latitude = String(Common.Coordinate.latitude)
//        let longitude = String(Common.Coordinate.longitude)
//
//        var user_id = Common.customerModel.user_id
//
//        if (Common.check_wallet == true) {
//
//            self.deal_id = Common.customerModel.wallets[Common.wallet_pos].deal_id!
//
//        } else {
//
//            self.deal_id = Common.customerModel.bars[select_pos].deal[Common.toTicketfordeal_index].deal_id!
//
//        }
//
//        var deal_id = self.deal_id
//        var lat = latitude
//        var lon = longitude
//
//        //up to server
//        let url = Common.api_location + "add_claim.php"
//
//        let params = ["user_id": user_id,
//                      "deal_id": deal_id,
//                      "lat": lat,
//                      "lon": lon] as [String : Any]
//
//        do {
//            let opt = try HTTP.POST(url, parameters: params)
//            self.activeIndicator.isHidden = false
//            self.activeIndicator.startAnimating()
//            self.view.isUserInteractionEnabled = false
//            
//
//            //get from server
//            opt?.run { response in
//                if let error = response.error {
//
//                    DispatchQueue.main.sync(execute: {
//
//                        self.view.isUserInteractionEnabled = true
//                        
//                        MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
//
//                        // stop timer
//                        self.activeIndicator.stopAnimating()
//                        self.activeIndicator.isHidden = true
//                        self.timer.invalidate()
//
//                        return
//                    })
//
//                }
//                do {
//
//                    Common.customerModel = try CustomerModel(JSONLoader(response.text!))
//                    if Common.customerModel.success == "true" {
//                        self.flag = true
//
//                    }else {
//
//                        DispatchQueue.main.sync(execute: {
//
//                            self.view.isUserInteractionEnabled = true
//                            
//                            MessageBoxViewController.showAlert(self, title: "Error", message: Common.customerModel.message!)
//
//                            // stop timer
//                            self.activeIndicator.stopAnimating()
//                            self.activeIndicator.isHidden = true
//                            self.timer.invalidate()
//
//                            return
//                        })
//                    }
//                } catch {
//                    //Toast.toast("Json string error: \(error)")
//                }
//            }
//        } catch let error {
//            //Toast.toast("Request error: \(error)")
//        }
//
//    }

}
