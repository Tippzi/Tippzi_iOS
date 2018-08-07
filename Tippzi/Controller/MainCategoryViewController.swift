//
//  CategoryViewController.swift
//  Tippzi
//
//  Created by Admin on 12/25/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import CoreLocation

class MainCategoryViewController: UIViewController {

    @IBOutlet weak var venueCategoryButton: UIButton!
    @IBOutlet weak var dealCategoryButton: UIButton!
    @IBOutlet weak var tippziGoButton: UIButton!
    @IBOutlet weak var btnSignOut: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnSignOut.titleLabel?.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].sub_button_size))

    }
    
    @IBAction func btnSignOutClick(_ sender: Any) {
        
        self.defaults.set("", forKey: "user_type")
        self.defaults.set("", forKey: "user_id")
        //        Common.flagofMapViewbyCategory = ""
        GPPSignIn.sharedInstance().signOut()
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "SigninView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }

    @IBAction func venueCategoryAction(_ sender: Any) {
        Common.select_category = "All"
        Common.selectcategory = [LocationModel]()
        var category_deal = [SelectCategoryDeal]()
        Common.category_name = Common.select_category
        for i in 0 ..< Common.customerModel.bars.count {
            if Common.select_category != Common.customerModel.bars[i].category {
                var bar_id = Common.customerModel.bars[i].bar_id
                var barTitle = Common.customerModel.bars[i].business_name
                var music_type = Common.customerModel.bars[i].music_type
                var latitude = CLLocationDegrees(Common.customerModel.bars[i].lat!)
                var longitude = CLLocationDegrees(Common.customerModel.bars[i].lon!)
                if latitude == nil {
                    latitude = 0
                }
                if longitude == nil {
                    longitude = 0
                }
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
                
                Common.selectcategory += [LocationModel(index_num: Int(bar_id!)!, latitude: latitude!, longitude: longitude!,  selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle!, music_type: music_type!, category_name: Common.customerModel.bars[i].category!, address: address!, service_name: service_name!)]
                
            }
        }
        
        if Common.selectcategory.count == 0 {
            
            MessageBoxViewController.showAlert(self, title: "Alert", message: "There is not bars in this category.")
            
            self.view.isUserInteractionEnabled = true
            
            //transition effect
            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainCategoryViewController")
            
            let transition = CATransition()
            transition.type = kCATransitionFromBottom
            transition.subtype = kCATransitionFromBottom
            //transition.duration = 0.2
            view.window!.layer.add(transition, forKey: kCATransition)
            toViewController?.modalPresentationStyle = UIModalPresentationStyle.popover
            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(toViewController!, animated: true, completion:nil)
            
        }
        else {
            
            Common.flagOfMapViewFromCategory = true
            
            Common.select_page_in = 0
            Common.select_pos = 0
            
            self.view.isUserInteractionEnabled = true
            
            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomerMap")
            
            let transition = CATransition()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            //transition.duration = 0.5
            view.window!.layer.add(transition, forKey: kCATransition)
            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(toViewController!, animated: true, completion:nil)
            
        }
    }
    @IBAction func dealCategoryAction(_ sender: Any) {
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    @IBAction func tippziGoAction(_ sender: Any) {
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TippziGoMapViewController")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
}
