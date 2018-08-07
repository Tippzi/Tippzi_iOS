//
//  TicketViewController.swift
//  Tippzi
//
//  Created by Admin on 11/7/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy
import CoreLocation

class TicketViewController: UIViewController {
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var btnAddtoWallet: UIButton!
    @IBOutlet weak var btnShareDeal: UIButton!
    @IBOutlet weak var btnClaim: UIButton!
    
    @IBOutlet weak var addtowalletLabel: UILabel!
    
    @IBOutlet weak var labClaim: UILabel!
    @IBOutlet weak var labBusinessName: UILabel!
    @IBOutlet weak var labMusicType: UILabel!
    @IBOutlet weak var labOpenTime: UILabel!
    
    @IBOutlet weak var labDuration1: UILabel!
    @IBOutlet weak var labDealName: UILabel!
//    @IBOutlet weak var labDealDescription: UITextView!
    @IBOutlet weak var labDealDescription: UILabel!
    
    @IBOutlet weak var labRemain: UILabel!
    @IBOutlet weak var labDuration2: UILabel!
    
    @IBOutlet weak var titcket_descrip_label: UILabel!
    
    @IBOutlet weak var upImage: UIImageView!
    @IBOutlet weak var redeemedImage: UIImageView!
    @IBOutlet weak var middleImage: UIImageView!
    @IBOutlet weak var downImage: UIImageView!
    
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var timewalkBtn: UIButton!
    
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    var weekday: Int = 0
    var opentime : String = ""
    var bar_id: String = ""
    var deal_id: String = ""
    var select_pos : Int = 0
    
    var distance_min : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //font size set
        labBusinessName.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        labClaim.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        labMusicType.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labOpenTime.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        timewalkBtn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labDuration1.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labDealName.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].deal_name_size))
        labDealDescription.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].description_size))
        labRemain.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labDuration2.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        titcket_descrip_label.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bottom_labelfont))
        
        btnClaim.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        addtowalletLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        btnShareDeal.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))

        addtowalletLabel.layer.borderColor = UIColor.black.cgColor
        addtowalletLabel.layer.borderWidth = 2
        addtowalletLabel.layer.cornerRadius = addtowalletLabel.frame.height/2
        addtowalletLabel.layer.masksToBounds = true
        btnShareDeal.layer.cornerRadius = btnShareDeal.frame.height/2
        
        btnBack.isEnabled = true
        
        self.activeIndicator.isHidden = true
        
        upImage.layer.cornerRadius = 5
        middleImage.layer.cornerRadius = 5
        downImage.layer.cornerRadius = 5
        
        // get current date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date = formatter.string(from: date)
        
        // get current day of week
        weekday = getDayOfWeek(today: current_date)
        
        for i in 0...Common.customerModel.bars.count-1{
            if Int(Common.customerModel.bars[i].bar_id!) == Common.select_barid {
                select_pos = i
            }
        }
        
        if (Common.check_wallet == true) { // came from AddWallet Screen
            
            if Common.from_claimdeal == true { // when Yes of ClaimAlert is clicked
                
                labBusinessName.text = Common.temp_walletModel.labBusinessName
                labMusicType.text = Common.temp_walletModel.labMusicType
                opentime = Common.temp_walletModel.opentime
                
                if (Common.temp_walletModel.claimed_check == "true") {
                    
                    labClaim.text = ""
                    btnClaim.isEnabled = false
                    redeemedImage.isHidden = false
                    middleImage.image = UIImage(named: "ico_ticket_bar_2.png")
                    btnClose.setImage(UIImage(named: "ico_close_hint.png"), for: .normal)
                    labDuration1.isHidden = true
                    
                } else {
                    
                    labClaim.text = "Claim This Deal"
                    btnClaim.isEnabled = true
                    
                }
                
                if opentime == " - " {
                    
                    labOpenTime.text = "Closed"
                }
                else{
                    
                    labOpenTime.text = opentime
                }
                
                timewalkBtn.setTitle(Common.temp_walletModel.labDistance + " mins walk", for: .normal)
                
                labDuration1.text = Common.temp_walletModel.labDuration1
                
                labDealName.text = Common.temp_walletModel.labDealName
                labDealDescription.text = Common.temp_walletModel.labDealDescription
                
                labRemain.text = "Hurry, only " + String(Int(Common.temp_walletModel.remain)! - 1) + " left!"
                
                labDuration2.text = Common.temp_walletModel.labDuration2
                
                btnAddtoWallet.isEnabled = false
                addtowalletLabel.backgroundColor = MyColor.customWalletButtonBackgroundColor()
                addtowalletLabel.textColor = MyColor.customWalletButtonTextColor()
                addtowalletLabel.layer.borderColor = MyColor.customWalletButtonBackgroundColor().cgColor
                
                Common.from_claimdeal = false
                Common.temp_walletModel = Temp_walletModel()
               
            }
            else {
                
                Common.temp_walletModel = Temp_walletModel()
                
                let walletModel = Common.customerModel.wallets[Common.wallet_pos]
                
                labBusinessName.text = walletModel.business_name
                labMusicType.text = walletModel.music_type
                
                if weekday == 2 {
                    
                    opentime = (walletModel.openHour?.mon_start)! + " - " + (walletModel.openHour?.mon_end)!
                }
                else if weekday == 3 {
                    
                    opentime = (walletModel.openHour?.tue_start)! + " - " + (walletModel.openHour?.tue_end)!
                }
                else if weekday == 4 {
                    
                    opentime = (walletModel.openHour?.wed_start)! + " - " + (walletModel.openHour?.wed_end)!
                }
                else if weekday == 5 {
                    
                    opentime = (walletModel.openHour?.thur_start)! + " - " + (walletModel.openHour?.thur_end)!
                }
                else if weekday == 6 {
                    
                    opentime = (walletModel.openHour?.fri_start)! + " - " + (walletModel.openHour?.fri_end)!
                }
                else if weekday == 7 {
                    
                    opentime = (walletModel.openHour?.sat_start)! + " - " + (walletModel.openHour?.sat_end)!
                }
                else if weekday == 1 {
                    
                    opentime = (walletModel.openHour?.sun_start)! + " - " + (walletModel.openHour?.sun_end)!
                }
                
                if (walletModel.claimed_check == "true") {
                    
                    labClaim.text = ""
                    btnClaim.isEnabled = false
                    redeemedImage.isHidden = false
                    middleImage.image = UIImage(named: "ico_ticket_bar_2.png")
                    btnClose.setImage(UIImage(named: "ico_close1_hint.png"), for: .normal)
                    labDuration1.isHidden = true
                    
                } else {
                    
                    labClaim.text = "Claim This Deal"
                    btnClaim.isEnabled = true
                    
                }
                
                if opentime == " - " {
                    
                    labOpenTime.text = "Closed"
                }
                else{
                    
                    labOpenTime.text = opentime
                }
                
                let distance = Int(cal_walk_time(distance: walletModel.distance!))!
                if distance > 20 {
                    distance_min = "20 +"
                }
                else {
                    distance_min = String(describing: distance)
                }
                
                timewalkBtn.setTitle(distance_min + " mins walk", for: .normal)
                
                labDuration1.text = "Exp " + walletModel.duration!
                
                labDealName.text = walletModel.title
                labDealDescription.text = walletModel.description
                
                Common.select_dealtitle_descrip = walletModel.title! + "\n" + walletModel.description!
                
                labRemain.text = "Hurry, only " + String(Int(walletModel.qty!)! - Int(walletModel.claimed!)!) + " left!"
                
                labDuration2.text = "Exp " + walletModel.duration!
                
                btnAddtoWallet.isEnabled = false
                addtowalletLabel.backgroundColor = MyColor.customWalletButtonBackgroundColor()
                addtowalletLabel.textColor = MyColor.customWalletButtonTextColor()
                addtowalletLabel.layer.borderColor = MyColor.customWalletButtonBackgroundColor().cgColor
                
                Common.temp_walletModel.labBusinessName = labBusinessName.text!
                Common.temp_walletModel.labMusicType = labMusicType.text!
                Common.temp_walletModel.opentime = opentime
                Common.temp_walletModel.claimed_check = walletModel.claimed_check!
                Common.temp_walletModel.labDistance = distance_min
                Common.temp_walletModel.labDuration1 = labDuration1.text!
                Common.temp_walletModel.labDealName = labDealName.text!
                Common.temp_walletModel.labDealDescription = labDealDescription.text!
                Common.temp_walletModel.remain = String(Int(walletModel.qty!)! - Int(walletModel.claimed!)!)
                Common.temp_walletModel.labDuration2 = labDuration2.text!
                
            }
            
            
        } else { // came from BarDetail Screen
            
            if Common.from_claimdeal == true && Int(Common.temp_walletModel.remain) == 1 { // when remain is 1 and claim
                
                labBusinessName.text = Common.temp_walletModel.labBusinessName
                labMusicType.text = Common.temp_walletModel.labMusicType
                opentime = Common.temp_walletModel.opentime
                
                if (Common.temp_walletModel.claimed_check == "true") {
                    
                    labClaim.text = ""
                    //                btnClaim.setTitle("The deal has been claimed", for: .normal)
                    btnClaim.isEnabled = false
                    redeemedImage.isHidden = false
                    middleImage.image = UIImage(named: "ico_ticket_bar_2.png")
                    btnClose.setImage(UIImage(named: "ico_close_hint.png"), for: .normal)
                    labDuration1.isHidden = true
                    
                } else {
                    
                    labClaim.text = "Claim This Deal"
                    //                btnClaim.setTitle("Claim This Deal", for: .normal)
                    btnClaim.isEnabled = true
                    
                }
                
                if opentime == " - " {
                    
                    labOpenTime.text = "Closed"
                }
                else{
                    
                    labOpenTime.text = opentime
                }
                
                timewalkBtn.setTitle(Common.temp_walletModel.labDistance + " mins walk", for: .normal)
                
                labDuration1.text = Common.temp_walletModel.labDuration1
                
                labDealName.text = Common.temp_walletModel.labDealName
                labDealDescription.text = Common.temp_walletModel.labDealDescription
                
                labRemain.text = "Hurry, only " + String(Int(Common.temp_walletModel.remain)! - 1) + " left!"
                
                labDuration2.text = Common.temp_walletModel.labDuration2
                
                btnAddtoWallet.isEnabled = false
                addtowalletLabel.backgroundColor = MyColor.customWalletButtonBackgroundColor()
                addtowalletLabel.textColor = MyColor.customWalletButtonTextColor()
                addtowalletLabel.layer.borderColor = MyColor.customWalletButtonBackgroundColor().cgColor
                
                Common.from_claimdeal = false
                Common.temp_walletModel = Temp_walletModel()
                
            }
            else { //when remain >= 1
                
                Common.temp_walletModel = Temp_walletModel()
            
                let barModel = Common.customerModel.bars[select_pos]
                
                let dealModel = Common.customerModel.bars[select_pos].deal[Common.toTicketfordeal_index]
                
                labBusinessName.text = barModel.business_name
                labMusicType.text = barModel.music_type
                
                if weekday == 2 {
                    
                    opentime = (barModel.openHour?.mon_start)! + " - " + (barModel.openHour?.mon_end)!
                }
                else if weekday == 3 {
                    
                    opentime = (barModel.openHour?.tue_start)! + " - " + (barModel.openHour?.tue_end)!
                }
                else if weekday == 4 {
                    
                    opentime = (barModel.openHour?.wed_start)! + " - " + (barModel.openHour?.wed_end)!
                }
                else if weekday == 5 {
                    
                    opentime = (barModel.openHour?.thur_start)! + " - " + (barModel.openHour?.thur_end)!
                }
                else if weekday == 6 {
                    
                    opentime = (barModel.openHour?.fri_start)! + " - " + (barModel.openHour?.fri_end)!
                }
                else if weekday == 7 {
                    
                    opentime = (barModel.openHour?.sat_start)! + " - " + (barModel.openHour?.sat_end)!
                }
                else if weekday == 1 {
                    
                    opentime = (barModel.openHour?.sun_start)! + " - " + (barModel.openHour?.sun_end)!
                }
                
                if opentime == " - " {
                    
                    labOpenTime.text = "Closed"
                }
                else{
                    
                    labOpenTime.text = opentime
                }
                
                let distance = Int(cal_walk_time(distance: barModel.distance!))!
                if distance > 20 {
                    distance_min = "20 +"
                }
                else {
                    distance_min = String(describing: distance)
                }
                
                timewalkBtn.setTitle(distance_min + " mins walk", for: .normal)
                
                labDuration1.text = "Exp " + dealModel.duration!
                labDealName.text = dealModel.title
                labDealDescription.text = dealModel.description
                Common.select_dealtitle_descrip = dealModel.title! + "\n" + dealModel.description!
                var remain = Int(dealModel.qty!)! - Int(dealModel.claimed!)!
                labRemain.text = "Hurry, only " + String(remain) + " left!"
                labDuration2.text = "Exp " + dealModel.duration!
                
                if (dealModel.claimed_check == "true") {
                    
                    labClaim.text = ""
                    //                btnClaim.setTitle("The deal has been claimed", for: .normal)
                    btnClaim.isEnabled = false
                    
                    redeemedImage.isHidden = false
                    middleImage.image = UIImage(named: "ico_ticket_bar_2.png")
                    btnClose.setImage(UIImage(named: "ico_close_hint.png"), for: .normal)
                    labDuration1.isHidden = true
                    
                    btnAddtoWallet.isEnabled = false
                    addtowalletLabel.backgroundColor = MyColor.customWalletButtonBackgroundColor()
                    addtowalletLabel.textColor = MyColor.customWalletButtonTextColor()
                    addtowalletLabel.layer.borderColor = MyColor.customWalletButtonBackgroundColor().cgColor
                } else {
                    
                    if (dealModel.wallet_check == "true") {
                        
                        btnAddtoWallet.isEnabled = false
                        addtowalletLabel.backgroundColor = MyColor.customWalletButtonBackgroundColor()
                        addtowalletLabel.textColor = MyColor.customWalletButtonTextColor()
                        addtowalletLabel.layer.borderColor = MyColor.customWalletButtonBackgroundColor().cgColor
                    } else {
                        
                        btnAddtoWallet.isHidden = false
                        
                    }
                    
                    labClaim.text = "Claim this Deal"
                    //                btnClaim.setTitle("Claim this Deal", for: .normal)
                    btnClaim.isEnabled = true
                    
                }
            
                if remain == 1   {
                    
                    Common.temp_walletModel.labBusinessName = labBusinessName.text!
                    Common.temp_walletModel.labMusicType = labMusicType.text!
                    Common.temp_walletModel.opentime = opentime
                    Common.temp_walletModel.claimed_check = dealModel.claimed_check!
                    Common.temp_walletModel.labDistance = distance_min
                    Common.temp_walletModel.labDuration1 = labDuration1.text!
                    Common.temp_walletModel.labDealName = labDealName.text!
                    Common.temp_walletModel.labDealDescription = labDealDescription.text!
                    Common.temp_walletModel.remain = String(Int(dealModel.qty!)! - Int(dealModel.claimed!)!)
                    Common.temp_walletModel.labDuration2 = labDuration2.text!
                }
                
            }
            
        }
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
       
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    // get current day of week
    func getDayOfWeek(today:String)->Int {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
        
    }
    
    func cal_walk_time(distance:String)->String {
    
        var walk_sec: CGFloat = 0.0
        
        if let str = NumberFormatter().number(from: distance) {
            
            walk_sec = CGFloat(str)
        }
        
        walk_sec = walk_sec * 1000 / 1.5
    
        let temp: Int = Int(walk_sec)
    
        let mins: Int = temp / 60;
    
        let time: String = String(mins)
    
        return time
        
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        
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
    
    @IBAction func btnBackUpClick(_ sender: Any) {
        
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
    
    @IBAction func Goto_RouteView(_ sender: Any) {
        
        Common.fromTicket_toRoute_flag = true
        
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RouteViewController") {
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.duration = 0.5
            view.window!.layer.add(transition, forKey: kCATransition)
            viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            viewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    // goto AddWalletView
    @objc func finishedResponse() {
        // timer
        if self.flag == false {
            return
        }
        
        self.activeIndicator.stopAnimating()
        self.activeIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
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
    }
    
    @IBAction func btnClaimClick(_ sender: Any) {
      
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "ClaimAlertView")
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    //share deal button Click
    @IBAction func btnShareDealClick(_ sender: Any) {
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShareDealPopUpView")
        
        let transition = CATransition()
        transition.type = kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    // add wallet button Click
    @IBAction func btnWalletClick(_ sender: Any) {
        
        btnBack.isEnabled = false
        btnClose.isEnabled = false
        btnAddtoWallet.isEnabled = false
        btnShareDeal.isEnabled = false
        
        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        
        let latitude = String(Common.Coordinate.latitude)
        let longitude = String(Common.Coordinate.longitude)
        
        var user_id = Common.customerModel.user_id
        
        if (Common.check_wallet == true) {
            
            self.bar_id = Common.customerModel.wallets[Common.wallet_pos].bar_id!
            self.deal_id = Common.customerModel.wallets[Common.wallet_pos].deal_id!
            
        } else {
            
            self.bar_id = Common.customerModel.bars[select_pos].bar_id!
            self.deal_id = Common.customerModel.bars[select_pos].deal[Common.toTicketfordeal_index].deal_id!
            
        }
        
        var bar_id = self.bar_id
        var deal_id = self.deal_id
        var lat = latitude
        var lon = longitude
        
        //up to server
        let url = Common.api_location + "add_wallet.php"
        
        let params = ["user_id": user_id,
                      "bar_id": bar_id,
                      "deal_id": deal_id,
                      "lat": lat,
                      "lon": lon] as [String : Any]
        
        do {
            let opt = try HTTP.POST(url, parameters: params)
            self.activeIndicator.isHidden = false
            self.activeIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
            
            
            //get from server
            opt?.run { response in
                if let error = response.error {
                    
                    DispatchQueue.main.sync(execute: {
                        
                        self.view.isUserInteractionEnabled = true
                        
                        MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                        
                        // stop timer
                        self.activeIndicator.stopAnimating()
                        self.activeIndicator.isHidden = true
                        self.timer.invalidate()
                        
                        self.btnBack.isEnabled = true
                        self.btnClose.isEnabled = true
                        self.btnAddtoWallet.isEnabled = true
                        self.btnShareDeal.isEnabled = true
                        
                        return
                    })
                    
                }
                do {
                    
                    Common.customerModel = try CustomerModel(JSONLoader(response.text!))
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
                            
                            self.btnBack.isEnabled = true
                            self.btnClose.isEnabled = true
                            self.btnAddtoWallet.isEnabled = true
                            self.btnShareDeal.isEnabled = true
                            
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
