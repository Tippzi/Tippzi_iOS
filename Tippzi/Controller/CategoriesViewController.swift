//
//  CategoriesViewController.swift
//  Tippzi
//
//  Created by Admin on 12/20/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy
import CoreLocation

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GPPSignInDelegate {
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!

    @IBOutlet weak var headtitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let defaults = UserDefaults.standard
    
    var signIn : GPPSignIn?
    var cell : CategoriesItemViewCell? = nil
    let cellSpacingHeight: CGFloat = 10
    var height : CGFloat = 0
    var arrayOfArray = ["Nightlife", "Health & Fitness", "Hair & Beauty"]
    var category_id : Int = 0
    var category_name : String = ""
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    var rate : CGFloat = 0
    var table_width : CGFloat = 0
    var category_image_width : CGFloat = 1280
    var category_image_height : CGFloat = 800
    /**/
    var previous = NSDecimalNumber.one
    var current = NSDecimalNumber.one
    var position: UInt = 1
    var updateTimer: Timer?
    /**/
    var mapdataFetch : MapDataFetch = MapDataFetch()
    public func finished(withAuth auth: GTMOAuth2Authentication!, error: Error!){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activeIndicator.isHidden = true
        //font size set
        headtitle.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        //tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        rate = category_image_height / category_image_width
        table_width = UIScreen.main.bounds.size.width - 60
        self.tableView.frame = CGRect.init(x: ((self.tableView.frame.origin.x)+15), y: (self.tableView.frame.origin.y), width: table_width, height: (self.tableView.frame.height))

        
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayOfArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        height = table_width * rate
        return height
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        cell = CategoriesItemViewCell.instanceFromNib() as! CategoriesItemViewCell
        
        let choice = arrayOfArray[indexPath.section]
        let choice_index = indexPath.section
        
        //font size set
        //        cell?.imgCategories.image = UIImage(named : choice)
        
        cell?.imgCategories.layer.cornerRadius = 10
        cell?.imgCategories.layoutMargins.left = 15
        cell?.imgCategories.layoutMargins.right = 15
        cell?.layoutMargins.left = 15
        
        cell?.categoryLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        if choice_index == 0 {
            cell?.imgCategories.image = UIImage(named : "ico_Nightlife.jpg")
            cell?.categoryLabel.text = choice
            cell?.categoryLabel.textColor = UIColor.white
            cell?.imgCategories_small.image = UIImage(named : "ico_location_category1")
            cell?.imgCategories_small.frame = CGRect.init(x: ((cell?.imgCategories_small.frame.origin.x))!, y: (cell?.imgCategories_small.frame.origin.y)!, width: 20, height: 15)
        }
        else if choice_index == 1 {
            
            cell?.imgCategories.image = UIImage(named : "ico_Health_Fitness.jpg")
            cell?.categoryLabel.text = choice
            cell?.categoryLabel.textColor = UIColor.white
            cell?.imgCategories_small.image = UIImage(named : "ico_location_category2")
            cell?.imgCategories_small.frame = CGRect.init(x: ((cell?.imgCategories_small.frame.origin.x))!, y: (cell?.imgCategories_small.frame.origin.y)!, width: 20, height: 15)
        }
        else if choice_index == 2 {
            
            cell?.imgCategories.image = UIImage(named : "ico_Hair_Beauty.jpg")
            cell?.categoryLabel.text = choice
            cell?.categoryLabel.textColor = UIColor.white
            cell?.imgCategories_small.image = UIImage(named : "ico_location_category3")
            cell?.imgCategories_small.frame = CGRect.init(x: ((cell?.imgCategories_small.frame.origin.x))!, y: (cell?.imgCategories_small.frame.origin.y)!, width: 20, height: 15)
        }
        
        cell?.btnCategory.addTarget(self, action: #selector(Select), for: .touchUpInside)
        return (cell)!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NSLog("Table view scroll detected at offset: %f",scrollView.contentOffset.y)
    }
    
    @IBAction func Select(_ sender: Any){
        let superview = (sender as AnyObject).superview
        let cell = superview??.superview as? CategoriesItemViewCell
        
        let indexPath = self.tableView.indexPath(for: cell!)
        let choices = arrayOfArray[(indexPath?.section)!]
        
        category_id = (indexPath?.section)!
        if category_id == 0
        {
            self.category_name = "Nightlife"
            SelectCategory(self.category_name)
            
        }
        else if category_id == 1
        {
            self.category_name = "Health & Fitness"
            SelectCategory(self.category_name)
        }
        else if category_id == 2
        {
            self.category_name = "Hair & Beauty"
            SelectCategory(self.category_name)
        }
    }
    
    @objc func finishedResponse() {
        
        Common.selectcategory = [LocationModel]()
        var category_deal = [SelectCategoryDeal]()
        Common.category_name = Common.select_category
        for i in 0 ..< Common.customerModel.bars.count {
            if Common.select_category == Common.customerModel.bars[i].category {
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
                
                Common.selectcategory += [LocationModel(index_num: Int(bar_id!)!, latitude: latitude!, longitude: longitude!,  selectcategory_deal: category_deal, barImage: barImage, barTitle: barTitle!, music_type: music_type!, category_name: Common.select_category, address: address!, service_name: service_name!)]
                
            }
        }
        
        if Common.selectcategory.count == 0 {
            
            MessageBoxViewController.showAlert(self, title: "Alert", message: "There is not bars in this category.")
            
            self.view.isUserInteractionEnabled = true
            
            self.activeIndicator.isHidden = true
            self.activeIndicator.stopAnimating()
            timer.invalidate()
            
            //transition effect
            self.navigationController?.popViewController(animated: true)
//            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainCategoryViewController")
            
//            let transition = CATransition()
//            transition.type = kCATransitionFromBottom
//            transition.subtype = kCATransitionFromBottom
//            //transition.duration = 0.2
//            view.window!.layer.add(transition, forKey: kCATransition)
//            toViewController?.modalPresentationStyle = UIModalPresentationStyle.popover
//            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
//            self.present(toViewController!, animated: true, completion:nil)
            
        }
        else {
            
            Common.flagOfMapViewFromCategory = true
            
            Common.select_page_in = 0
            Common.select_pos = 0
            
            self.view.isUserInteractionEnabled = true
            
            self.activeIndicator.isHidden = true
            self.activeIndicator.stopAnimating()
            timer.invalidate()
            
            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomerMap")
            self.navigationController?.pushViewController(toViewController!, animated: true)
            
//            let transition = CATransition()
//            transition.type = kCATransitionPush
//            transition.subtype = kCATransitionFromRight
//            //transition.duration = 0.5
//            view.window!.layer.add(transition, forKey: kCATransition)
//            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
//            self.present(toViewController!, animated: true, completion:nil)
            
        }
        
    }
    
    func SelectCategory(_ select_category : String){
        
        Common.select_category = select_category
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        self.activeIndicator.isHidden = false
        self.activeIndicator.startAnimating()
        
    }
}

