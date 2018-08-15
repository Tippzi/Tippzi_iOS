//
//  CustomerBarDetailViewController.swift
//  Tippzi
//
//  Created by Admin on 11/26/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import Koloda
import ImageSlideshow
import CoreLocation
import MessageUI
import SwiftHTTP
import JSONJoy

class CustomerBarDetailViewController: UIViewController, KolodaViewDelegate,  KolodaViewDataSource, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var imageslideshow: ImageSlideshow!
    @IBOutlet weak var descriptionTitleView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var openHourView: UIView!
    @IBOutlet weak var kolodaView: KolodaView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var timewalkBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var barTitle: UILabel!
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var BriefDescriptionTitle: UILabel!
    @IBOutlet weak var descriptionLabel: VerticalAlignLabel!
    @IBOutlet weak var OpenHourTitle: UILabel!
    @IBOutlet weak var monday: UILabel!
    @IBOutlet weak var tuesday: UILabel!
    @IBOutlet weak var wednesday: UILabel!
    @IBOutlet weak var thursday: UILabel!
    @IBOutlet weak var friday: UILabel!
    @IBOutlet weak var saturday: UILabel!
    @IBOutlet weak var sunday: UILabel!
    @IBOutlet weak var monday_hour: UILabel!
    @IBOutlet weak var tuesday_hour: UILabel!
    @IBOutlet weak var wednesday_hour: UILabel!
    @IBOutlet weak var thursday_hour: UILabel!
    @IBOutlet weak var friday_hour: UILabel!
    @IBOutlet weak var saturday_hour: UILabel!
    @IBOutlet weak var sunday_hour: UILabel!
    @IBOutlet weak var telephone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var businessname: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnScrollUpDown: UIButton!
    
    let defaults = UserDefaults.standard
    
    var index_count : Int = 0
    var detailmodels = [BarDetailModel]()
    var downloadImage : [AlamofireSource] = [AlamofireSource]()
    var weekday: Int = 0
    var opentime : String = ""
    var select_pos : Int = 0
    var imageslideshow_height : CGFloat = 0.0
    var imageslideshow_temp_height : CGFloat = 0.0
    var is_image : Int = 0
    
    var scroll_falg : Bool = false
    
    var height : [CGFloat]?
    var add_all_Height : CGFloat = 0
    
    var myView_ypos : CGFloat = 0.0
    var imageslideshow_ypos : CGFloat = 0.0
    var descriptionTitleView_ypos : CGFloat = 0.0
    var descriptionView_ypos : CGFloat = 0.0
    var openhourView_ypos : CGFloat = 0.0
    var kolodaView_ypos : CGFloat = 0.0
    var heightOfdescriptionView : CGFloat = 0.0
    
    var user_id : String = ""
    var bar_id : String = ""
    var engagement_qty : Int = 0
    var index_value1 : Int = 0
    var page_index : Int = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        //font size set
        pageLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        timeLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        barTitle.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        timewalkBtn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        //
        for i in 0...Common.customerModel.bars.count-1{
            if Int(Common.customerModel.bars[i].bar_id!) == Common.select_barid {
                select_pos = i
            }
        }
        
        for i in 0...Common.customerModel.bars[select_pos].deal.count-1 {
            var remain_value = "Hurry, only " + String(Int(Common.customerModel.bars[select_pos].deal[i].qty!)! - Int(Common.customerModel.bars[select_pos].deal[i].claimed!)!) + " left"
            var exp_duration = "Exp " + Common.customerModel.bars[select_pos].deal[i].duration!
            var title = Common.customerModel.bars[select_pos].deal[i].title
            var deal_description = Common.customerModel.bars[select_pos].deal[i].description
            detailmodels += [BarDetailModel(title!, deal_description!, exp_duration,remain_value,i)]
        }
        
        OpenHourTitle.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        monday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        tuesday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        wednesday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        thursday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        friday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        saturday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        sunday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        monday_hour.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        tuesday_hour.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        wednesday_hour.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        thursday_hour.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        friday_hour.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        saturday_hour.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        sunday_hour.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        telephone.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        email.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        businessname.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        address.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        BriefDescriptionTitle.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        descriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        barTitle.text = Common.customerModel.bars[select_pos].business_name
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date = formatter.string(from: date)
        
        // get current day of week
        weekday = getDayOfWeek(today: current_date)
        
        display_opentime(index_count)
        
        pageLabel.text = String(index_count + 1) + " of " + String(Common.customerModel.bars[select_pos].deal.count) + " deals"
        index_count = 1
        
        descriptionLabel.text = Common.customerModel.bars[select_pos].description
        
        height = [CGFloat]()
        
        if !(Common.customerModel.bars[select_pos].background1?.isEmpty)! {
            
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.customerModel.bars[select_pos].background1!))!)
            height?.append(CGFloat(Float(Common.customerModel.bars[select_pos].background1_height!)!)*SCREEN_WIDTH)
        }
        if !(Common.customerModel.bars[select_pos].background2?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.customerModel.bars[select_pos].background2!))!)
            height?.append(CGFloat(Float(Common.customerModel.bars[select_pos].background2_height!)!)*SCREEN_WIDTH)
        }
        if !(Common.customerModel.bars[select_pos].background3?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.customerModel.bars[select_pos].background3!))!)
            height?.append(CGFloat(Float(Common.customerModel.bars[select_pos].background3_height!)!)*SCREEN_WIDTH)
        }
        if !(Common.customerModel.bars[select_pos].background4?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.customerModel.bars[select_pos].background4!))!)
            height?.append(CGFloat(Float(Common.customerModel.bars[select_pos].background4_height!)!)*SCREEN_WIDTH)
        }
        if !(Common.customerModel.bars[select_pos].background5?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.customerModel.bars[select_pos].background5!))!)
            height?.append(CGFloat(Float(Common.customerModel.bars[select_pos].background5_height!)!)*SCREEN_WIDTH)
        }
        if !(Common.customerModel.bars[select_pos].background6?.isEmpty)! {
            downloadImage.append(AlamofireSource(urlString:(Common.download + Common.customerModel.bars[select_pos].background6!))!)
            height?.append(CGFloat(Float(Common.customerModel.bars[select_pos].background6_height!)!)*SCREEN_WIDTH)
        }
        
        myView_ypos = -20
        imageslideshow_ypos = myView_ypos + myView.frame.height
        
        if downloadImage.count == 0 {
            
            myView.frame = CGRect.init(x: 0, y: myView_ypos , width: myView.frame.width, height: myView.frame.height)
            add_all_Height += myView.frame.height
            
            imageslideshow.isHidden = true
            imageslideshow.frame = CGRect.init(x: 0, y: imageslideshow_ypos , width: imageslideshow.frame.width, height: 0)
            
            self.heightOfdescriptionView = self.heightForView(text: self.descriptionLabel.text!, font: self.descriptionLabel.font , width: self.descriptionLabel.frame.width) + 20
            
            self.descriptionTitleView_ypos = self.imageslideshow_ypos
            
            if self.heightOfdescriptionView == 20 {
                
                self.descriptionTitleView.isHidden = true
                self.descriptionTitleView.frame = CGRect.init(x: 0, y: self.descriptionTitleView_ypos , width: self.descriptionTitleView.frame.width, height: 0)
                
            }
            else {
                
                self.descriptionTitleView.frame = CGRect.init(x: 0, y: self.descriptionTitleView_ypos , width: self.descriptionTitleView.frame.width, height: self.descriptionTitleView.frame.height)
                self.add_all_Height += self.descriptionTitleView.frame.height
            }
            
            self.descriptionView_ypos = self.descriptionTitleView_ypos + self.descriptionTitleView.frame.height
            descriptionView.frame = CGRect.init(x: 0, y: descriptionView_ypos , width: descriptionView.frame.width, height: heightOfdescriptionView)
            add_all_Height += heightOfdescriptionView
            
            openhourView_ypos = descriptionView_ypos + descriptionView.frame.height
            openHourView.frame = CGRect.init(x: 0, y: openhourView_ypos , width: openHourView.frame.width, height: openHourView.frame.height)
            add_all_Height += openHourView.frame.height
            
            self.scrollView.addSubview(self.myView)
            self.scrollView.addSubview(self.imageslideshow)
            self.scrollView.addSubview(self.descriptionTitleView)
            self.scrollView.addSubview(self.descriptionView)
            self.scrollView.addSubview(self.openHourView)
            self.scrollView.addSubview(self.kolodaView)
            
            scrollView.contentSize.height = add_all_Height - 15
            
            let testView = UIView(frame : CGRect.init(x:0, y:openhourView_ypos, width:self.myView.frame.width, height:1000))
            testView.backgroundColor = UIColor.white
            self.myView.addSubview(testView)
            
        }
        else if downloadImage.count == 1 {
            
            imageslideshow.backgroundColor = MyColor.customCircleFillColor()
            imageslideshow.slideshowInterval = 5.0
            imageslideshow.pageControl.isHidden = true
            imageslideshow.contentScaleMode = UIViewContentMode.scaleToFill
            
            self.myView.frame = CGRect.init(x: 0, y: self.myView_ypos , width: self.myView.frame.width, height: self.myView.frame.height)
            self.add_all_Height += self.myView.frame.height
            
            self.imageslideshow.frame = CGRect.init(x: 0, y: self.imageslideshow_ypos , width: self.imageslideshow.frame.width, height: self.height![0])
            self.add_all_Height += self.height![0]
            
            self.imageslideshow.setImageInputs(downloadImage)
            
            self.heightOfdescriptionView = self.heightForView(text: self.descriptionLabel.text!, font: self.descriptionLabel.font , width: self.descriptionLabel.frame.width) + 20
            
            self.descriptionTitleView_ypos = self.imageslideshow_ypos + self.height![0]
            
            if self.heightOfdescriptionView == 20 {
                
                self.descriptionTitleView.isHidden = true
                self.descriptionTitleView.frame = CGRect.init(x: 0, y: self.descriptionTitleView_ypos , width: self.descriptionTitleView.frame.width, height: 0)
                
            }
            else {
                
                self.descriptionTitleView.frame = CGRect.init(x: 0, y: self.descriptionTitleView_ypos , width: self.descriptionTitleView.frame.width, height: self.descriptionTitleView.frame.height)
                self.add_all_Height += self.descriptionTitleView.frame.height
            }
            
            self.descriptionView_ypos = self.descriptionTitleView_ypos + self.descriptionTitleView.frame.height
            self.descriptionView.frame = CGRect.init(x: 0, y: self.descriptionView_ypos , width: self.descriptionView.frame.width, height: self.heightOfdescriptionView)
            self.add_all_Height += self.heightOfdescriptionView
            
            self.openhourView_ypos = self.descriptionView_ypos + self.descriptionView.frame.height
            self.openHourView.frame = CGRect.init(x: 0, y: self.openhourView_ypos , width: self.openHourView.frame.width, height: self.openHourView.frame.height)
            self.add_all_Height += self.openHourView.frame.height
            
            self.scrollView.addSubview(self.myView)
            self.scrollView.addSubview(self.imageslideshow)
            self.scrollView.addSubview(self.descriptionTitleView)
            self.scrollView.addSubview(self.descriptionView)
            self.scrollView.addSubview(self.openHourView)
            self.scrollView.addSubview(self.kolodaView)
            
            self.scrollView.contentSize.height = self.add_all_Height - 15
            
            let testView = UIView(frame : CGRect.init(x:0, y: self.openhourView_ypos, width:self.myView.frame.width, height:1000))
            testView.backgroundColor = UIColor.white
            self.myView.addSubview(testView)
            
            self.add_all_Height = 0
            
        }
        else
        {
            
            //default
            self.myView.frame = CGRect.init(x: 0, y: self.myView.frame.origin.y , width: self.myView.frame.width, height: self.myView.frame.height)
            self.add_all_Height += self.myView.frame.height
            
            self.imageslideshow.frame = CGRect.init(x: 0, y: self.imageslideshow_ypos , width: self.imageslideshow.frame.width, height: self.height![0])
            self.add_all_Height += self.height![0]
            
            self.heightOfdescriptionView = self.heightForView(text: self.descriptionLabel.text!, font: self.descriptionLabel.font , width: self.descriptionLabel.frame.width) + 20
            
            self.descriptionTitleView_ypos = self.imageslideshow_ypos + self.height![0]
            
            if self.heightOfdescriptionView == 20 {
                
                self.descriptionTitleView.isHidden = true
                self.descriptionTitleView.frame = CGRect.init(x: 0, y: self.descriptionTitleView_ypos , width: self.descriptionTitleView.frame.width, height: 0)
                
            }
            else {
                
                self.descriptionTitleView.frame = CGRect.init(x: 0, y: self.descriptionTitleView_ypos , width: self.descriptionTitleView.frame.width, height: self.descriptionTitleView.frame.height)
                self.add_all_Height += self.descriptionTitleView.frame.height
            }
            
            self.descriptionView_ypos = self.descriptionTitleView_ypos + self.descriptionTitleView.frame.height
            self.descriptionView.frame = CGRect.init(x: 0, y: self.descriptionView_ypos , width: self.descriptionView.frame.width, height: self.heightOfdescriptionView)
            self.add_all_Height += self.heightOfdescriptionView
            
            self.openhourView_ypos = self.descriptionView_ypos + self.descriptionView.frame.height
            self.openHourView.frame = CGRect.init(x: 0, y: self.openhourView_ypos , width: self.openHourView.frame.width, height: self.openHourView.frame.height)
            self.add_all_Height += self.openHourView.frame.height
            
            self.scrollView.addSubview(self.myView)
            self.scrollView.addSubview(self.imageslideshow)
            self.scrollView.addSubview(self.descriptionTitleView)
            self.scrollView.addSubview(self.descriptionView)
            self.scrollView.addSubview(self.openHourView)
            self.scrollView.addSubview(self.kolodaView)
            
            self.scrollView.contentSize.height = self.add_all_Height - 15
            
            let testView = UIView(frame : CGRect.init(x:0, y: self.openhourView_ypos, width:self.myView.frame.width, height:1000))
            testView.backgroundColor = UIColor.white
            self.myView.addSubview(testView)
            
            self.add_all_Height = 0
            //
            imageslideshow.backgroundColor = MyColor.customCircleFillColor()
            imageslideshow.slideshowInterval = 5.0
            imageslideshow.pageControl.isHidden = true
            imageslideshow.contentScaleMode = UIViewContentMode.scaleToFill
            imageslideshow.activityIndicator = DefaultActivityIndicator()
            
            imageslideshow.currentPageChanged = { page in
                
                self.myView.frame = CGRect.init(x: 0, y: self.myView.frame.origin.y , width: self.myView.frame.width, height: self.myView.frame.height)
                self.add_all_Height += self.myView.frame.height
                
                self.imageslideshow.frame = CGRect.init(x: 0, y: self.imageslideshow_ypos , width: self.imageslideshow.frame.width, height: self.height![page])
                self.add_all_Height += self.height![page]
                
                self.heightOfdescriptionView = self.heightForView(text: self.descriptionLabel.text!, font: self.descriptionLabel.font , width: self.descriptionLabel.frame.width) + 20
                
                self.descriptionTitleView_ypos = self.imageslideshow_ypos + self.height![page]
                
                if self.heightOfdescriptionView == 20 {
                    
                    self.descriptionTitleView.isHidden = true
                    self.descriptionTitleView.frame = CGRect.init(x: 0, y: self.descriptionTitleView_ypos , width: self.descriptionTitleView.frame.width, height: 0)
                    
                }
                else {
                    
                    self.descriptionTitleView.frame = CGRect.init(x: 0, y: self.descriptionTitleView_ypos , width: self.descriptionTitleView.frame.width, height: self.descriptionTitleView.frame.height)
                    self.add_all_Height += self.descriptionTitleView.frame.height
                }
                
                self.descriptionView_ypos = self.descriptionTitleView_ypos + self.descriptionTitleView.frame.height
                self.descriptionView.frame = CGRect.init(x: 0, y: self.descriptionView_ypos , width: self.descriptionView.frame.width, height: self.heightOfdescriptionView)
                self.add_all_Height += self.heightOfdescriptionView
                
                self.openhourView_ypos = self.descriptionView_ypos + self.descriptionView.frame.height
                self.openHourView.frame = CGRect.init(x: 0, y: self.openhourView_ypos , width: self.openHourView.frame.width, height: self.openHourView.frame.height)
                self.add_all_Height += self.openHourView.frame.height
                
                self.scrollView.addSubview(self.myView)
                self.scrollView.addSubview(self.imageslideshow)
                self.scrollView.addSubview(self.descriptionTitleView)
                self.scrollView.addSubview(self.descriptionView)
                self.scrollView.addSubview(self.openHourView)
                self.scrollView.addSubview(self.kolodaView)
                
                self.scrollView.contentSize.height = self.add_all_Height - 15
                
                let testView = UIView(frame : CGRect.init(x:0, y: self.openhourView_ypos, width:self.myView.frame.width, height:1000))
                testView.backgroundColor = UIColor.white
                self.myView.addSubview(testView)
                
                self.add_all_Height = 0
             
            }
            
            imageslideshow.setImageInputs(downloadImage)
        }
        
        monday_hour.text = make_first_hour(day_start: (Common.customerModel.bars[select_pos].openHour?.mon_start)!, day_end: (Common.customerModel.bars[select_pos].openHour?.mon_end)!)
        if monday_hour.text == " - "
        {
            monday_hour.text = "Closed"
        }
        tuesday_hour.text = make_first_hour(day_start: (Common.customerModel.bars[select_pos].openHour?.tue_start)!, day_end: (Common.customerModel.bars[select_pos].openHour?.tue_end)!)
        if tuesday_hour.text == " - "
        {
            tuesday_hour.text = "Closed"
        }
        wednesday_hour.text = make_first_hour(day_start: (Common.customerModel.bars[select_pos].openHour?.wed_start)!, day_end: (Common.customerModel.bars[select_pos].openHour?.wed_end)!)
        if wednesday_hour.text == " - "
        {
            wednesday_hour.text = "Closed"
        }
        thursday_hour.text = make_first_hour(day_start: (Common.customerModel.bars[select_pos].openHour?.thur_start)!, day_end: (Common.customerModel.bars[select_pos].openHour?.thur_end)!)
        if thursday_hour.text == " - "
        {
            thursday_hour.text = "Closed"
        }
        friday_hour.text = make_first_hour(day_start: (Common.customerModel.bars[select_pos].openHour?.fri_start)!, day_end: (Common.customerModel.bars[select_pos].openHour?.fri_end)!)
        if friday_hour.text == " - "
        {
            friday_hour.text = "Closed"
        }
        saturday_hour.text = make_first_hour(day_start: (Common.customerModel.bars[select_pos].openHour?.sat_start)!, day_end: (Common.customerModel.bars[select_pos].openHour?.sat_end)!)
        if saturday_hour.text == " - "
        {
            saturday_hour.text = "Closed"
        }
        sunday_hour.text = make_first_hour(day_start: (Common.customerModel.bars[select_pos].openHour?.sun_start)!, day_end: (Common.customerModel.bars[select_pos].openHour?.sun_end)!)
        if sunday_hour.text == " - "
        {
            sunday_hour.text = "Closed"
        }
        
        telephone.text = Common.customerModel.bars[select_pos].telephone
        if !((telephone.text?.isEmpty)!) {
            telephone.isUserInteractionEnabled = true
            let telephone_tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(telephone_action))
            telephone.addGestureRecognizer(telephone_tap)
        }

        email.text = Common.customerModel.bars[select_pos].email
        if !((email.text?.isEmpty)!){
            
            email.isUserInteractionEnabled = true
            let email_tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(email_action))
            email.addGestureRecognizer(email_tap)
        }
        
        businessname.text = Common.customerModel.bars[select_pos].business_name
        businessname.isUserInteractionEnabled = true
        let businessname_tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(businessname_action))
        businessname.addGestureRecognizer(businessname_tap)
        
        address.text = Common.customerModel.bars[select_pos].address! +  " " + Common.customerModel.bars[select_pos].post_code!
        address.isUserInteractionEnabled = true
        let address_tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(address_action))
        address.addGestureRecognizer(address_tap)
        
        address.sizeToFit()
        self.index_value1 = 0
       
        // Gif arrow ac
        let jeremyGif = UIImage.gifImageWithName("ico_arrow")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: (SCREEN_WIDTH - 40) / 2, y: SCREEN_HEIGHT - 70, width: 40, height: 40)
        view.addSubview(imageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        ////////////////////////
        
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
    }
    
    
   
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
    func make_first_hour(day_start: String, day_end: String) -> String {
        
        let day_str : String!
        
        if !day_start.isEmpty && day_end.isEmpty {
            
            day_str = day_start + " - " + "      "
            return day_str
        }
        else {
            
            day_str = day_start + " - " + day_end
            return day_str
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        scrollView.scrollToBottom()
    }
    
    @objc func telephone_action(sender:UITapGestureRecognizer)
    {
        engagement_qty += 1
        let url: NSURL = URL(string: "tel://" + telephone.text!)! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @objc func email_action(sender:UITapGestureRecognizer)
    {
        engagement_qty += 1
        let mailCmpose = MFMailComposeViewController()
        mailCmpose.mailComposeDelegate = self
        mailCmpose.setToRecipients([email.text!])
        mailCmpose.setSubject("MyEmail")
        mailCmpose.setMessageBody("", isHTML: false)
        
        if MFMailComposeViewController.canSendMail()
        {
            self.present(mailCmpose, animated: true, completion: nil)
        }
        else
        {
            self.showSendMailErrorAlert()
        }
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func address_action(sender:UITapGestureRecognizer)
    {
        engagement_qty += 1
        select_pos = 0
        Common.fromBarDetail_toMap_flag = true
        Engagement_Add()
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomerMap")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @objc func businessname_action(sender:UITapGestureRecognizer)
    {
        engagement_qty += 1
        select_pos = 0
        Common.fromBarDetail_toMap_flag = true
        Engagement_Add()
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomerMap")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    func display_opentime(_ index_num : Int){
        let barModel = Common.customerModel.bars[select_pos]
        let dealModel = Common.customerModel.bars[select_pos].deal[index_num]
        
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
            
            timeLabel.text = "Closed"
        }
        else{
            
            timeLabel.text = opentime
        }
        
        var distance_min : String = ""
        let distance = Int(cal_walk_time(distance: barModel.distance!))!
        if distance > 20 {
            distance_min = "20 +"
        }
        else {
            distance_min = String(describing: distance)
        }
        
        timewalkBtn.setTitle(distance_min + " mins walk", for: .normal)
        
        //        scrollView.contentSize.width = self.view.frame.width
    }
    
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
    
    @IBAction func BackAction(_ sender: Any) {
        
        select_pos = 0
        Common.fromBarDetail_toMap_flag = true
        
        Engagement_Add()
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomerMap")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
    }
    
    @IBAction func Goto_RouteView(_ sender: Any) {
        Common.fromBarDetail_toRoute_flag = true
        
        engagement_qty += 1
        Engagement_Add()
        
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
    
    @IBAction func CardExitAction(_ sender: Any) {
        if index_count < detailmodels.count {
            display_opentime(index_count-1)
            kolodaView?.swipe(.right)
        } else {
            kolodaView?.swipe(.right)
        }
    }
    
    @IBAction func underAction(_ sender: Any) {
        if index_count > 0 {
            index_count = index_count - 1
            if index_count == 0 {
                index_count = 1
                kolodaView?.reloadData()
            }
            display_opentime(index_count-1)
            pageLabel.text = String(index_count) + " of " + String(Common.customerModel.bars[select_pos].deal.count) + " deals"
            
            kolodaView?.revertAction()
        }else {
            display_opentime(index_count)
            
        }
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = koloda.currentCardIndex
        for i in 0...Common.customerModel.bars[select_pos].deal.count-1 {
            var remain_value = "Hurry, only " + String(Int(Common.customerModel.bars[select_pos].deal[i].qty!)! - Int(Common.customerModel.bars[select_pos].deal[i].claimed!)!) + " left"
            var exp_duration = "Exp " + Common.customerModel.bars[select_pos].deal[i].duration!
            var title = Common.customerModel.bars[select_pos].deal[i].title
            var deal_descriptio = Common.customerModel.bars[select_pos].deal[i].description
            detailmodels += [BarDetailModel(title!, description, exp_duration,remain_value,i)]
        }
        koloda.insertCardAtIndexRange(position..<position + detailmodels.count, animated: true)
    }
    

    func koloda(_ koloda : KolodaView, shouldSwipeCardAt index: Int, in direction : SwipeResultDirection)->Bool {
        
        var get_index = koloda.currentCardIndex
        index_count = get_index + 1
        if index_count < detailmodels.count  {
            pageLabel.text = String(index_count + 1) + " of " + String(Common.customerModel.bars[select_pos].deal.count) + " deals"
            index_count += 1
            display_opentime(index_count-1)
            return true
        } else {
            koloda.resetCurrentCardIndex()
            koloda.reloadData()
            var get_index = koloda.currentCardIndex
            index_count = get_index + 1
            display_opentime(index_count-1)
            pageLabel.text = String(index_count) + " of " + String(Common.customerModel.bars[select_pos].deal.count) + " deals"
            return false
        }
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        var index = koloda.currentCardIndex
        return true
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return detailmodels.count
    }
    
//    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
//        koloda.swipe(.right)
//        return true
//    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let infoWindow = CU_CardView.instanceFromNib() as! CU_CardView
        
        infoWindow.layer.cornerRadius = 8
        infoWindow.layer.masksToBounds = true
        
        //font size set
        infoWindow.dealTitleLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        infoWindow.descriptionLabel.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].description_size))
        //        infoWindow.descriptionLabel.sizeToFit()
        //        infoWindow.descriptionLabel.makeLabelTextPosition(sampleLabel: infoWindow.descriptionLabel, positionIdentifier: "VerticalAlignmentTop")
        infoWindow.durationText.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        infoWindow.duration.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        
        infoWindow.claimBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        //
        
        if Common.customerModel.bars[select_pos].deal[index].claimed_check == "true" {
            
            infoWindow.claimedLabel.isHidden = false
            if Common.customerModel.bars[select_pos].category == "Nightlife" {
                infoWindow.claimedLabel.backgroundColor = MyColor.MarkLabelCategory0()
            }
            else if Common.customerModel.bars[select_pos].category == "Health & Fitness" {
                infoWindow.claimedLabel.backgroundColor = MyColor.MarkLabelCategory1()
            }
            else if Common.customerModel.bars[select_pos].category == "Hair & Beauty" {
                infoWindow.claimedLabel.backgroundColor = MyColor.MarkLabelCategory2()
            }
            infoWindow.claimedLabel.text = "CLAIMED"
            infoWindow.claimedLabel.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size) - 3.0)
            infoWindow.image1.image = UIImage(named : "ico_ticket_active1")
            infoWindow.image2.image = UIImage(named : "ico_ticket_button1")
            infoWindow.dealTitleLabel.text = detailmodels[index].deal_name
            infoWindow.dealTitleLabel.textColor = MyColor.ClaimedDealTitle()
            infoWindow.descriptionLabel.text = detailmodels[index].deal_description
            infoWindow.durationText.text = detailmodels[index].remain
            infoWindow.duration.text = detailmodels[index].duration
            infoWindow.claimBtn.layer.cornerRadius = infoWindow.claimBtn.frame.height / 2
            infoWindow.claimBtn.backgroundColor = MyColor.customWalletButtonBackgroundColor()
            infoWindow.claimBtn.setTitle("Claimed", for: .normal)
            infoWindow.claimBtn.addTarget(self, action: #selector(SelectClaim), for: .touchUpInside)
        }
        else {
            
            infoWindow.dealTitleLabel.text = detailmodels[index].deal_name
            infoWindow.descriptionLabel.text = detailmodels[index].deal_description
            infoWindow.durationText.text = detailmodels[index].remain
            infoWindow.duration.text = detailmodels[index].duration
            
            infoWindow.claimBtn.layer.cornerRadius = infoWindow.claimBtn.frame.height / 2
            infoWindow.claimBtn.addTarget(self, action: #selector(SelectClaim), for: .touchUpInside)
        }
        
        return infoWindow
    }
    
    @IBAction func SelectClaim(_ sender: Any){
   
        Common.toTicketfordeal_index = kolodaView.currentCardIndex
        Common.check_wallet = false
        
        Engagement_Add()
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TicketView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    @IBAction func btnScrollClick(_ sender: Any) {
        
        if scroll_falg == false{
            let image = UIImage(named: "ico_back_up")
            btnScrollUpDown.setImage(image, for: .normal)
            scrollView.scrollToBottom()
            scroll_falg = true
        }
        else
        {
            let image = UIImage(named: "ico_back_down")
            btnScrollUpDown.setImage(image, for: .normal)
            self.scrollView.scrollToTop()
            scroll_falg = false
        }
        
    }
    
    func Engagement_Add()
    {
       
        user_id = Common.customerModel.user_id!
        bar_id = Common.customerModel.bars[select_pos].bar_id!

        //up to server
        let url = Common.api_location + "add_engagement.php"
        let params = ["user_id": user_id,
                      "bar_id": bar_id,
                      "qty": engagement_qty] as [String : Any]

        do {
            let opt = try HTTP.POST(url, parameters: params)

//            self.view.isUserInteractionEnabled = false
            

            //get from server
            opt?.run { response in
                if let error = response.error {

                    DispatchQueue.main.sync(execute: {

//                        self.view.isUserInteractionEnabled = true
                        
                        // MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")

                        return
                    })

                }
                do {

                    Common.customerModel = try CustomerModel(JSONLoader(response.text!))

                } catch {
                    // //Toast.toast("Json string error: \(error)")
                }
            }
        } catch let error {
            // //Toast.toast("Request error: \(error)")
        }
    }
    
}

extension UILabel{
    func makeLabelTextPosition (sampleLabel :UILabel?, positionIdentifier : String) -> UILabel
    {
        let rect = sampleLabel!.textRect(forBounds: bounds, limitedToNumberOfLines: 0)
        
        switch positionIdentifier
        {
        case "VerticalAlignmentTop":
            sampleLabel!.frame = CGRect.init(x: (sampleLabel?.bounds.origin.x)!, y: (sampleLabel?.bounds.origin.y)! , width: (sampleLabel?.frame.width)!, height: (sampleLabel?.frame.height)!)
            break;
            
        case "VerticalAlignmentMiddle":
            sampleLabel!.frame = CGRect.init(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2,
                                             width : rect.size.width, height : rect.size.height);
            break;
            
        case "VerticalAlignmentBottom":
            sampleLabel!.frame = CGRect.init(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height);
            break;
            
        default:
            sampleLabel!.frame = bounds;
            break;
        }
        return sampleLabel!
        
    }
    
}

extension UIScrollView {
    
    func scrollToBottom() {
            let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
            setContentOffset(bottomOffset, animated: true)
    }
    
    func scrollToTop() {
        let topOffset = CGPoint(x: 0, y: -contentInset.top - 20)
        setContentOffset(topOffset, animated: true)
    }
    
}

extension UIImage {
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL? = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL!) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a! < b! {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        
        return animation
    }
}
