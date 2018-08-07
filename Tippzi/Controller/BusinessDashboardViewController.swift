//
//  BusinessDashboardViewController.swift
//  Tippzi
//
//  Created by Admin on 11/9/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

class BusinessDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GPPSignInDelegate {
    func finished(withAuth auth: GTMOAuth2Authentication!, error: Error!) {
        
    }
    
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    var decoder : JSONLoader!
    //Timer format
    var timer:Timer = Timer()
    var flag:Bool = false
    
    @IBOutlet weak var impressionTitleLabel: UILabel!
    @IBOutlet weak var clicksTitleLabel: UILabel!
    @IBOutlet weak var engagementsTitleLabel: UILabel!
    
    @IBOutlet weak var ImageGalleryLabel: UILabel!
    @IBOutlet weak var businessprofileDesclabel: UILabel!
    @IBOutlet weak var businessprofileTitleLabel: UILabel!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myaccountLabel: UILabel!
    @IBOutlet weak var btneditprofile: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnAddDeal: UIButton!
    @IBOutlet weak var btnSignOut: UIButton!
    
    @IBOutlet weak var labBusinessName: UILabel!
    @IBOutlet weak var btnMapView: UIButton!
    @IBOutlet weak var labBusinessName1: UILabel!
    @IBOutlet weak var labCategoryName: UILabel!
    @IBOutlet weak var labAddress: UILabel!
    @IBOutlet weak var labTelephone: UILabel!
    @IBOutlet weak var labEmail: UILabel!
    @IBOutlet weak var labDescription: UILabel!
    @IBOutlet weak var labMusicType: UILabel!
    
    @IBOutlet weak var explainView: UIView!
    @IBOutlet weak var profileInfoView: UIView!
    @IBOutlet weak var yourBusinessProfileView: UIView!
    @IBOutlet weak var businessNameView: UIView!
    @IBOutlet weak var categoryNameView: UIView!
    @IBOutlet weak var address_checkView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var telephoneView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var line1View: UIView!
    
    @IBOutlet weak var description_checkView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var musictypeView: UIView!
    @IBOutlet weak var line2View: UIView!
    @IBOutlet weak var open_HoursView: UIView!
    @IBOutlet weak var line3View: UIView!
    @IBOutlet weak var imageGalleryView: UIView!
    @IBOutlet weak var image1View: UIView!
    @IBOutlet weak var image2View: UIView!
    @IBOutlet weak var editProfileButtonView: UIView!
    
    @IBOutlet weak var imgCheck1: UIImageView!
    @IBOutlet weak var imgCheck2: UIImageView!
    @IBOutlet weak var imgCheck3: UIImageView!
    @IBOutlet weak var imgCheck4: UIImageView!
    @IBOutlet weak var imgCheck5: UIImageView!
    @IBOutlet weak var imgCheck6: UIImageView!
    @IBOutlet weak var imgCheck7: UIImageView!
    @IBOutlet weak var imgCheck8: UIImageView!
    @IBOutlet weak var imgCheck9: UIImageView!
    
    @IBOutlet weak var dealHeaderLabel: UILabel!
    
    @IBOutlet weak var expLabel: UILabel!
    @IBOutlet weak var addImageView: UIImageView!
    
    @IBOutlet weak var img1View: UIView!
    @IBOutlet weak var img2View: UIView!
    @IBOutlet weak var img3View: UIView!
    @IBOutlet weak var img4View: UIView!
    @IBOutlet weak var img5View: UIView!
    @IBOutlet weak var img6View: UIView!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    
    //tableview
    
    var cell : DealItemViewCell? = nil
    
    let cellReuseIdentifier = "item_cell"
    
    let cellSpacingHeight: CGFloat = 10
    
    var arrayOfArray = [DealItemModels]()
    
    
    @IBOutlet weak var labImpressions: UILabel!
    
    @IBOutlet weak var labEngagements: UILabel!
    
    @IBOutlet weak var labClicks: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labProgress: UILabel!
    
    @IBOutlet weak var labOverView: UILabel!
    
    @IBOutlet weak var labMonday: UILabel!
    @IBOutlet weak var labTuesday: UILabel!
    @IBOutlet weak var labWednesday: UILabel!
    @IBOutlet weak var labThursday: UILabel!
    @IBOutlet weak var labFriday: UILabel!
    @IBOutlet weak var labSaturday: UILabel!
    @IBOutlet weak var labSunday: UILabel!
    
    @IBOutlet weak var timeMonday: UILabel!
    @IBOutlet weak var timeTuesday: UILabel!
    @IBOutlet weak var timeWednesday: UILabel!
    @IBOutlet weak var timeThursday: UILabel!
    @IBOutlet weak var timeFriday: UILabel!
    @IBOutlet weak var timeSaturday: UILabel!
    @IBOutlet weak var timeSunday: UILabel!
    
    @IBOutlet weak var showProgress: UIProgressView!
    
    @IBOutlet weak var imgLine1: UIImageView!
    @IBOutlet weak var imgLine2: UIImageView!
    @IBOutlet weak var imgLine3: UIImageView!
    
    var index_count : Int = 0
    var last_height : CGFloat!
    var addDeal_yPos : CGFloat = 0.0
    var addDeal_height : CGFloat = 0.0
    var addBtn_yPos : CGFloat = 0.0
    var addImage_yPos : CGFloat = 0.0
    var expView_yPos : CGFloat = 0.0
    var profileInfo_yPos : CGFloat = 0.0
    var yourBusinessProfile_yPos : CGFloat = 0.0
    var businessName_yPos : CGFloat = 0.0
    var categoryName_yPos : CGFloat = 0.0
    var address_yPos : CGFloat = 0.0
    var telephone_yPos : CGFloat = 0.0
    var email_yPos : CGFloat = 0.0
    var line1_yPos : CGFloat = 0.0
    var description_yPos : CGFloat = 0.0
    var musictype_yPos : CGFloat = 0.0
    var line2_yPos : CGFloat = 0.0
    var open_Hours_yPos : CGFloat = 0.0
    var line3_yPos : CGFloat = 0.0
    var imageGallery_yPos : CGFloat = 0.0
    var image1_yPos : CGFloat = 0.0
    var image2_yPos : CGFloat = 0.0
    var editProfileButton_yPos : CGFloat = 0.0
    
    var tableHeight : CGFloat = 0;
    var add_all_Height : CGFloat = 0;
    var validText : String = ""
    var all_impressions : Int = 0
    var all_inwallet : Int = 0
    var all_claimed : Int = 0
    var all_engagements : Int = 0
    var all_clicks : Int = 0
    var progress1 : CGFloat = 0
    var progress : Int = 0
    var deal_count : Int = 0
    var lab_address : String = ""
    var heightOfdescriptionView : CGFloat = 0.0
    var heightOfaddressView : CGFloat = 0.0
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BusinessDashboardViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.activeIndicator.isHidden = true
        
        var desc_width = labDescription.frame.width
        myaccountLabel.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        labBusinessName.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].bar_name_size))
        labOverView.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size) - 1)
        labImpressions.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].count_size))
        labEngagements.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].count_size))
        labClicks.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].count_size))
        impressionTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        engagementsTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        clicksTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        dealHeaderLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        btnAddDeal.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        expLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labProgress.font =  UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        businessprofileDesclabel.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size) - 2.0)
        businessprofileTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].title_size))
        labBusinessName1.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labCategoryName.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labAddress.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labTelephone.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labEmail.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labDescription.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labMusicType.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labMonday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labTuesday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labWednesday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labThursday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labFriday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labSaturday.font =  UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        labSunday.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        timeMonday.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        timeTuesday.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        timeWednesday.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        timeThursday.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        timeFriday.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        timeSaturday.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        timeSunday.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        ImageGalleryLabel.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].comment_size))
        btneditprofile.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].button_size))
        btnSignOut.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].sub_button_size))
        
        scrollView.contentSize.width = self.view.frame.width
        
        btneditprofile.layer.cornerRadius = btneditprofile.frame.height/2
        btneditprofile.isEnabled = true
        
        btnAddDeal.layer.cornerRadius = 5
        
        if Common.businessModel.bars[0].deal.count > 0 {
            
            deal_count = Common.businessModel.bars[0].deal.count
            //labOverView.text = "Account Statistics : Deal " + String(deal_count)
            labOverView.text = "Account Statistics"
            
        }
        else{
            
//            labOverView.text = "Account Statistics : OverView"
            labOverView.text = "Account Statistics"
            
        }
        
        if !(Common.businessModel.bars[0].business_name?.isEmpty)! {
            labBusinessName.text = Common.businessModel.bars[0].business_name
            labBusinessName1.text = Common.businessModel.bars[0].business_name
            labBusinessName1.textColor = UIColor.black
        }
        if !(Common.businessModel.bars[0].category?.isEmpty)! {
            labCategoryName.text = Common.businessModel.bars[0].category
            labCategoryName.textColor = UIColor.black
        }
        
        if !(Common.businessModel.bars[0].address?.isEmpty)! && !(Common.businessModel.bars[0].post_code?.isEmpty)! {
            labAddress.text = Common.businessModel.bars[0].address! + " " + Common.businessModel.bars[0].post_code!
            labAddress.textColor = UIColor.black
        }
        
        if !(Common.businessModel.bars[0].telephone?.isEmpty)! {
            labTelephone.text = Common.businessModel.bars[0].telephone
            labTelephone.textColor = UIColor.black
        }
        if !(Common.businessModel.bars[0].email?.isEmpty)! {
            labEmail.text = Common.businessModel.bars[0].email
            labEmail.textColor = UIColor.black
        }
        if !(Common.businessModel.bars[0].description?.isEmpty)! {
            labDescription.text = Common.businessModel.bars[0].description
            labDescription.textColor = UIColor.black
        }
        if Common.businessModel.bars[0].category == "Nightlife" {
            if !(Common.businessModel.bars[0].music_type?.isEmpty)! {
                labMusicType.text = Common.businessModel.bars[0].music_type
                labMusicType.textColor = UIColor.black
            }
        } else {
            musictypeView.isHidden = true
        }
        
        
        let explained = "It's getting pretty lonely in here...\nAdd a deal to get started"
        expLabel.text = explained
        
        //tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        arrayOfArray = [DealItemModels]()
        if Common.businessModel.bars[0].deal.count > 0 {
            for index in 0...Common.businessModel.bars[0].deal.count-1 {
                validText = "Valid "
                if Common.businessModel.bars[0].deal[index].deal_days?.monday == "true" {
                    validText += "Mon, "
                }
                if Common.businessModel.bars[0].deal[index].deal_days?.tuesday == "true" {
                    validText += "Tue, "
                }
                if Common.businessModel.bars[0].deal[index].deal_days?.wednesday == "true" {
                    validText += "Wed, "
                }
                if Common.businessModel.bars[0].deal[index].deal_days?.thursday == "true" {
                    validText += "Thur, "
                }
                if Common.businessModel.bars[0].deal[index].deal_days?.friday == "true" {
                    validText += "Fri, "
                }
                if Common.businessModel.bars[0].deal[index].deal_days?.saturday == "true" {
                    validText += "Sat, "
                }
                if Common.businessModel.bars[0].deal[index].deal_days?.sunday == "true" {
                    validText += "Sun, "
                }
                
                var days_duration = validText + "Exp " + Common.businessModel.bars[0].deal[index].duration!
                
                arrayOfArray += [DealItemModels(Common.businessModel.bars[0].deal[index].title!,Common.businessModel.bars[0].deal[index].description!, days_duration, Common.businessModel.bars[0].deal[index].impressions!, Common.businessModel.bars[0].deal[index].in_wallet!, Common.businessModel.bars[0].deal[index].claimed!, index)]
            }
            
            all_impressions = Int(Common.businessModel.bars[0].deal[0].impressions!)!
                
            for index in 0...Common.businessModel.bars[0].deal.count-1  {
                
                tableHeight += 160 + cellSpacingHeight
                
                all_inwallet += Int(Common.businessModel.bars[0].deal[0].in_wallet!)!
                all_claimed += Int(Common.businessModel.bars[0].deal[0].claimed!)!
                
            }
            
            all_engagements = all_inwallet + Int(Common.businessModel.bars[0].deal[0].engagement!)!
            all_clicks = all_claimed + Int(Common.businessModel.bars[0].deal[0].clicks!)!
            
            labImpressions.text = String(all_impressions)
            if labImpressions.text != "0" {
                labImpressions.textColor = labBusinessName.textColor // change with white color when value is not 0, else default
            }
            labEngagements.text = String(all_engagements)

            if labEngagements.text != "0" {
                labEngagements.textColor = labBusinessName.textColor
            }
            labClicks.text = String(all_clicks)
            if labClicks.text != "0" {
                labClicks.textColor = labBusinessName.textColor
            }
            
        } else {
            tableView.isHidden = true
            tableView.frame = CGRect.init(x: self.tableView.frame.origin.x, y: addDeal_yPos, width: self.tableView.frame.width, height: 0)
        }
        
        // check and progress displays
        
        if (Common.businessModel.bars[0].business_name != "") {
            imgCheck1.image = UIImage(named: "ico_check.png")
            progress1 += 12.5
            progress = Int(progress1)
        }
        if (Common.businessModel.bars[0].category != "") {
            imgCheck9.image = UIImage(named: "ico_check.png")
        }
        if (Common.businessModel.bars[0].address != "") {
            imgCheck2.image = UIImage(named: "ico_check.png")
            progress1 += 12.5
            progress = Int(progress1)
        }
        if (Common.businessModel.bars[0].telephone != "") {
            imgCheck3.image = UIImage(named: "ico_check.png")
            progress1 += 12.5
            progress = Int(progress1)
        }
        if (Common.businessModel.bars[0].email != "") {
            imgCheck4.image = UIImage(named: "ico_check.png")
            progress1 += 12.5
            progress = Int(progress1)
        }
        if (Common.businessModel.bars[0].description != "") {
            imgCheck5.image = UIImage(named: "ico_check.png")
            
            progress1 += 12.5
            progress = Int(progress1)
        }
        if Common.businessModel.bars[0].category == "Nightlife" {
            if (Common.businessModel.bars[0].music_type != "") {
                imgCheck6.image = UIImage(named: "ico_check.png")
                progress1 += 12.5
                progress = Int(progress1)
            }
        } else {
            progress1 += 12.5
            progress = Int(progress1)
        }
        
        if ((Common.businessModel.bars[0].openHour?.mon_start != "") ||
            (Common.businessModel.bars[0].openHour?.mon_end != "") ||
            (Common.businessModel.bars[0].openHour?.tue_start != "") ||
            (Common.businessModel.bars[0].openHour?.tue_end != "") ||
            (Common.businessModel.bars[0].openHour?.wed_start != "") ||
            (Common.businessModel.bars[0].openHour?.wed_end != "") ||
            (Common.businessModel.bars[0].openHour?.thur_start != "") ||
            (Common.businessModel.bars[0].openHour?.thur_end != "") ||
            (Common.businessModel.bars[0].openHour?.fri_start != "") ||
            (Common.businessModel.bars[0].openHour?.fri_end != "") ||
            (Common.businessModel.bars[0].openHour?.sat_start != "") ||
            (Common.businessModel.bars[0].openHour?.sat_end != "") ||
            (Common.businessModel.bars[0].openHour?.sun_start != "") ||
            (Common.businessModel.bars[0].openHour?.sun_end != "")) {
            labMonday.textColor = UIColor.black
            imgCheck7.image = UIImage(named: "ico_check.png")
            progress1 += 12.5
            progress = Int(progress1)
        }
        if ((Common.businessModel.bars[0].bargallery?.background1 != "") ||
            (Common.businessModel.bars[0].bargallery?.background2 != "") ||
            (Common.businessModel.bars[0].bargallery?.background3 != "") ||
            (Common.businessModel.bars[0].bargallery?.background4 != "") ||
            (Common.businessModel.bars[0].bargallery?.background5 != "") ||
            (Common.businessModel.bars[0].bargallery?.background6 != "")) {
            ImageGalleryLabel.textColor = UIColor.black
            imgCheck8.image = UIImage(named: "ico_check.png")
            progress1 += 12.5
            progress = Int(progress1)
        }
        
        labProgress.text = "Your profile is " + String(progress) + "%" + " complete"
        
        showProgress.progress = Float(progress1) / 100
        showProgress.transform = showProgress.transform.scaledBy(x: 1, y: 4)
        showProgress.clipsToBounds = true
        showProgress.layer.cornerRadius = showProgress.frame.height / 2
        
        //display deal list
        //        dealHeader_yPos = dealHeaderLabel.frame.origin.y + dealHeaderLabel.frame.height
        
        addDeal_yPos = dealHeaderLabel.frame.origin.y + dealHeaderLabel.frame.height
        //        addDeal_yPos = addDeal_yPos + 5
        
        addBtn_yPos = addDeal_yPos + tableHeight + cellSpacingHeight
        
        addImage_yPos = addBtn_yPos + btnAddDeal.frame.height/2 - addImageView.frame.height/2
        
        expView_yPos = addBtn_yPos + btnAddDeal.frame.height
        
        var explainView_height : CGFloat = 0.0
        if Common.businessModel.bars[0].deal.count > 0 {
            
            explainView_height = 35.0
            expLabel.isHidden = true
            
        }
        else{
            
            explainView_height = self.explainView.frame.height
            
        }
        
        profileInfo_yPos = expView_yPos + explainView_height
        
        var profileInfoView_height : CGFloat = 0.0
        if progress == 100 {
            
            profileInfoView_height = 0.0
            
        }
        else{
            
            profileInfoView_height = self.profileInfoView.frame.height
            
        }
        
        yourBusinessProfile_yPos = profileInfo_yPos + profileInfoView_height
        
        businessName_yPos = yourBusinessProfile_yPos + yourBusinessProfileView.frame.height
        
        categoryName_yPos = businessName_yPos + businessNameView.frame.height
        
        address_yPos = categoryName_yPos + categoryNameView.frame.height
        
        heightOfaddressView = self.heightForView(text: self.labAddress.text!, font: self.labAddress.font! , width: self.labAddress.frame.width)
        if heightOfaddressView == 0 {
            heightOfaddressView = self.labAddress.frame.height
        }
        
        labAddress.frame = CGRect.init(x: self.labAddress.frame.origin.x, y: self.labAddress.frame.origin.y, width: self.labAddress.frame.width, height: heightOfaddressView)
        
        telephone_yPos = address_yPos + heightOfaddressView
        
        email_yPos = telephone_yPos + telephoneView.frame.height
        
        line1_yPos = email_yPos + emailView.frame.height
        
        description_yPos = line1_yPos + line1View.frame.height
        
        heightOfdescriptionView = self.heightForView(text: self.labDescription.text!, font: self.labDescription.font! , width: self.labDescription.frame.width)
        if heightOfdescriptionView == 0 {
            heightOfdescriptionView = self.labDescription.frame.height
        }
        
        labDescription.frame = CGRect.init(x: self.labDescription.frame.origin.x, y: self.labDescription.frame.origin.y, width: self.labDescription.frame.width, height: heightOfdescriptionView)
        
        // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        
        musictype_yPos = description_yPos + heightOfdescriptionView
        if Common.businessModel.bars[0].category == "Nightlife" {
            line2_yPos = musictype_yPos + musictypeView.frame.height
        } else {
            line2_yPos = musictype_yPos
        }
        
        open_Hours_yPos = line2_yPos + line2View.frame.height
        
        if ((Common.businessModel.bars[0].openHour?.mon_start != "") ||
            (Common.businessModel.bars[0].openHour?.mon_end != "") ||
            (Common.businessModel.bars[0].openHour?.tue_start != "") ||
            (Common.businessModel.bars[0].openHour?.tue_end != "") ||
            (Common.businessModel.bars[0].openHour?.wed_start != "") ||
            (Common.businessModel.bars[0].openHour?.wed_end != "") ||
            (Common.businessModel.bars[0].openHour?.thur_start != "") ||
            (Common.businessModel.bars[0].openHour?.thur_end != "") ||
            (Common.businessModel.bars[0].openHour?.fri_start != "") ||
            (Common.businessModel.bars[0].openHour?.fri_end != "") ||
            (Common.businessModel.bars[0].openHour?.sat_start != "") ||
            (Common.businessModel.bars[0].openHour?.sat_end != "") ||
            (Common.businessModel.bars[0].openHour?.sun_start != "") ||
            (Common.businessModel.bars[0].openHour?.sun_end != "")) {
            
            line3_yPos = open_Hours_yPos + labMonday.frame.height * 7 + 5
        }
        else {
            
            line3_yPos = open_Hours_yPos + musictypeView.frame.height
        }
        //        labBusinessName1.text = String(describing: open_Hours_yPos)
        //        labAddress.text = String(describing: line3_yPos)
        
        imageGallery_yPos = line3_yPos + line3View.frame.height
        
        image1_yPos = imageGallery_yPos + imageGalleryView.frame.height
        
        var array = [String]()
        
        if Common.businessModel.bars[0].bargallery?.background1 != "" {
            array.append((Common.businessModel.bars[0].bargallery?.background1)!)
        }
        if Common.businessModel.bars[0].bargallery?.background2 != "" {
            array.append((Common.businessModel.bars[0].bargallery?.background2)!)
        }
        if Common.businessModel.bars[0].bargallery?.background3 != "" {
            array.append((Common.businessModel.bars[0].bargallery?.background3)!)
        }
        if Common.businessModel.bars[0].bargallery?.background4 != "" {
            array.append((Common.businessModel.bars[0].bargallery?.background4)!)
        }
        if Common.businessModel.bars[0].bargallery?.background5 != "" {
            array.append((Common.businessModel.bars[0].bargallery?.background5)!)
        }
        if Common.businessModel.bars[0].bargallery?.background6 != "" {
            array.append((Common.businessModel.bars[0].bargallery?.background6)!)
        }
        
        var count_array : Int = array.count
        
        if count_array <= 3 {
            
            var imgurl : String = ""
            
            if count_array == 0 {
                
                image1View.isHidden = true
                image1View.frame = CGRect.init(x: 0, y: image1_yPos, width: self.image1View.frame.width, height: 0)
                image2View.isHidden = true
                image2View.frame = CGRect.init(x: 0, y: image2_yPos, width: self.image2View.frame.width, height: 0)
                
                editProfileButton_yPos = image1_yPos
                
            }
            else {
                if count_array == 1 {
                    
                    if array[0] != "" {
                        img1View.layer.cornerRadius = 5
                        img1View.layer.borderColor = UIColor.lightGray.cgColor
                        img1View.layer.borderWidth = 2
                        
                        imgurl = Common.download + array[0]
//                        let url = URL(string: imgurl)
//                        let data = try? Data(contentsOf: url!)
                        let url = URL(string: imgurl)
                        image1.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
//                        image1.image = UIImage(data: data!)
                        image1.contentMode = .scaleAspectFill
                        image1.layer.masksToBounds = false
                        image1.clipsToBounds = true
                        image1.layer.borderColor = UIColor.white.cgColor
                        image1.layer.borderWidth = 3
                        image1.layer.cornerRadius = 5
                    }
                }
                if count_array == 2 {
                    
                    if array[0] != "" {
                        img1View.layer.cornerRadius = 5
                        img1View.layer.borderColor = UIColor.lightGray.cgColor
                        img1View.layer.borderWidth = 2
                        
                        imgurl = Common.download + array[0]
//                        let url = URL(string: imgurl)
//                        let data = try? Data(contentsOf: url!)
//                        image1.image = UIImage(data: data!)
                        let url = URL(string: imgurl)
                        image1.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                        image1.contentMode = .scaleAspectFill
                        image1.layer.masksToBounds = false
                        image1.clipsToBounds = true
                        image1.layer.borderColor = UIColor.white.cgColor
                        image1.layer.borderWidth = 3
                        image1.layer.cornerRadius = 5
                    }
                    if array[1] != "" {
                        img2View.layer.cornerRadius = 5
                        img2View.layer.borderColor = UIColor.lightGray.cgColor
                        img2View.layer.borderWidth = 2
                        
                        imgurl = Common.download + array[1]
//                        let url = URL(string: imgurl)
//                        let data = try? Data(contentsOf: url!)
//                        image2.image = UIImage(data: data!)
                        let url = URL(string: imgurl)
                        image2.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                        image2.contentMode = .scaleAspectFill
                        image2.layer.masksToBounds = false
                        image2.clipsToBounds = true
                        image2.layer.borderColor = UIColor.white.cgColor
                        image2.layer.borderWidth = 3
                        image2.layer.cornerRadius = 5
                    }
                    
                }
                
                if count_array == 3 {
                    
                    if array[0] != "" {
                        img1View.layer.cornerRadius = 5
                        img1View.layer.borderColor = UIColor.lightGray.cgColor
                        img1View.layer.borderWidth = 2
                        
                        imgurl = Common.download + array[0]
//                        let url = URL(string: imgurl)
//                        let data = try? Data(contentsOf: url!)
//                        image1.image = UIImage(data: data!)
                        let url = URL(string: imgurl)
                        image1.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                        image1.contentMode = .scaleAspectFill
                        image1.layer.masksToBounds = false
                        image1.clipsToBounds = true
                        image1.layer.borderColor = UIColor.white.cgColor
                        image1.layer.borderWidth = 3
                        image1.layer.cornerRadius = 5
                    }
                    if array[1] != "" {
                        img2View.layer.cornerRadius = 5
                        img2View.layer.borderColor = UIColor.lightGray.cgColor
                        img2View.layer.borderWidth = 2
                        
                        imgurl = Common.download + array[1]
//                        let url = URL(string: imgurl)
//                        let data = try? Data(contentsOf: url!)
//                        image2.image = UIImage(data: data!)
                        let url = URL(string: imgurl)
                        image2.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                        image2.contentMode = .scaleAspectFill
                        image2.layer.masksToBounds = false
                        image2.clipsToBounds = true
                        image2.layer.borderColor = UIColor.white.cgColor
                        image2.layer.borderWidth = 3
                        image2.layer.cornerRadius = 5
                    }
                    if array[2] != "" {
                        img3View.layer.cornerRadius = 5
                        img3View.layer.borderColor = UIColor.lightGray.cgColor
                        img3View.layer.borderWidth = 2
                        
                        imgurl = Common.download + array[2]
//                        let url = URL(string: imgurl)
//                        let data = try? Data(contentsOf: url!)
//                        image3.image = UIImage(data: data!)
                        let url = URL(string: imgurl)
                        image3.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                        image3.contentMode = .scaleAspectFill
                        image3.layer.masksToBounds = false
                        image3.clipsToBounds = true
                        image3.layer.borderColor = UIColor.white.cgColor
                        image3.layer.borderWidth = 3
                        image3.layer.cornerRadius = 5
                    }
                    
                }
                
                image1View.frame = CGRect.init(x: 0, y: image1_yPos , width: self.image1View.frame.width, height: self.image1View.frame.height)
                add_all_Height += image1View.frame.height
                
                image2_yPos = image1_yPos + image1View.frame.height
                
                image2View.isHidden = true
                image2View.frame = CGRect.init(x: 0, y: image2_yPos, width: self.image2View.frame.width, height: 0)
                
                editProfileButton_yPos = image2_yPos
            }
            
        }
        else {
            
            var imgurl : String = ""
            
            if count_array == 4 {
                
                if array[0] != "" {
                    img1View.layer.cornerRadius = 5
                    img1View.layer.borderColor = UIColor.lightGray.cgColor
                    img1View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[0]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image1.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image1.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image1.contentMode = .scaleAspectFill
                    image1.layer.masksToBounds = false
                    image1.clipsToBounds = true
                    image1.layer.borderColor = UIColor.white.cgColor
                    image1.layer.borderWidth = 3
                    image1.layer.cornerRadius = 5
                }
                if array[1] != "" {
                    img2View.layer.cornerRadius = 5
                    img2View.layer.borderColor = UIColor.lightGray.cgColor
                    img2View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[1]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image2.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image2.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image2.contentMode = .scaleAspectFill
                    image2.layer.masksToBounds = false
                    image2.clipsToBounds = true
                    image2.layer.borderColor = UIColor.white.cgColor
                    image2.layer.borderWidth = 3
                    image2.layer.cornerRadius = 5
                }
                if array[2] != "" {
                    img3View.layer.cornerRadius = 5
                    img3View.layer.borderColor = UIColor.lightGray.cgColor
                    img3View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[2]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image3.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image3.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image3.contentMode = .scaleAspectFill
                    image3.layer.masksToBounds = false
                    image3.clipsToBounds = true
                    image3.layer.borderColor = UIColor.white.cgColor
                    image3.layer.borderWidth = 3
                    image3.layer.cornerRadius = 5
                }
                if array[3] != "" {
                    img4View.layer.cornerRadius = 5
                    img4View.layer.borderColor = UIColor.lightGray.cgColor
                    img4View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[3]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image4.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image4.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image4.contentMode = .scaleAspectFill
                    image4.layer.masksToBounds = false
                    image4.clipsToBounds = true
                    image4.layer.borderColor = UIColor.white.cgColor
                    image4.layer.borderWidth = 3
                    image4.layer.cornerRadius = 5
                }
                
            }
            if count_array == 5 {
                
                if array[0] != "" {
                    img1View.layer.cornerRadius = 5
                    img1View.layer.borderColor = UIColor.lightGray.cgColor
                    img1View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[0]
                    let url = URL(string: imgurl)
                    image1.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image1.image = UIImage(data: data!)
                    image1.contentMode = .scaleAspectFill
                    image1.layer.masksToBounds = false
                    image1.clipsToBounds = true
                    image1.layer.borderColor = UIColor.white.cgColor
                    image1.layer.borderWidth = 3
                    image1.layer.cornerRadius = 5
                }
                if array[1] != "" {
                    img2View.layer.cornerRadius = 5
                    img2View.layer.borderColor = UIColor.lightGray.cgColor
                    img2View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[1]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image2.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image2.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image2.contentMode = .scaleAspectFill
                    image2.layer.masksToBounds = false
                    image2.clipsToBounds = true
                    image2.layer.borderColor = UIColor.white.cgColor
                    image2.layer.borderWidth = 3
                    image2.layer.cornerRadius = 5
                }
                if array[2] != "" {
                    img3View.layer.cornerRadius = 5
                    img3View.layer.borderColor = UIColor.lightGray.cgColor
                    img3View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[2]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image3.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image3.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image3.contentMode = .scaleAspectFill
                    image3.layer.masksToBounds = false
                    image3.clipsToBounds = true
                    image3.layer.borderColor = UIColor.white.cgColor
                    image3.layer.borderWidth = 3
                    image3.layer.cornerRadius = 5
                }
                if array[3] != "" {
                    img4View.layer.cornerRadius = 5
                    img4View.layer.borderColor = UIColor.lightGray.cgColor
                    img4View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[3]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image4.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image4.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image4.contentMode = .scaleAspectFill
                    image4.layer.masksToBounds = false
                    image4.clipsToBounds = true
                    image4.layer.borderColor = UIColor.white.cgColor
                    image4.layer.borderWidth = 3
                    image4.layer.cornerRadius = 5
                }
                if array[4] != "" {
                    img5View.layer.cornerRadius = 5
                    img5View.layer.borderColor = UIColor.lightGray.cgColor
                    img5View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[4]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image5.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image5.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image5.contentMode = .scaleAspectFill
                    image5.layer.masksToBounds = false
                    image5.clipsToBounds = true
                    image5.layer.borderColor = UIColor.white.cgColor
                    image5.layer.borderWidth = 3
                    image5.layer.cornerRadius = 5
                }
                
            }
            if count_array == 6 {
                
                if array[0] != "" {
                    img1View.layer.cornerRadius = 5
                    img1View.layer.borderColor = UIColor.lightGray.cgColor
                    img1View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[0]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image1.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image1.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image1.contentMode = .scaleAspectFill
                    image1.layer.masksToBounds = false
                    image1.clipsToBounds = true
                    image1.layer.borderColor = UIColor.white.cgColor
                    image1.layer.borderWidth = 3
                    image1.layer.cornerRadius = 5
                }
                if array[1] != "" {
                    img2View.layer.cornerRadius = 5
                    img2View.layer.borderColor = UIColor.lightGray.cgColor
                    img2View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[1]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image2.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image2.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image2.contentMode = .scaleAspectFill
                    image2.layer.masksToBounds = false
                    image2.clipsToBounds = true
                    image2.layer.borderColor = UIColor.white.cgColor
                    image2.layer.borderWidth = 3
                    image2.layer.cornerRadius = 5
                }
                if array[2] != "" {
                    img3View.layer.cornerRadius = 5
                    img3View.layer.borderColor = UIColor.lightGray.cgColor
                    img3View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[2]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image3.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image3.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image3.contentMode = .scaleAspectFill
                    image3.layer.masksToBounds = false
                    image3.clipsToBounds = true
                    image3.layer.borderColor = UIColor.white.cgColor
                    image3.layer.borderWidth = 3
                    image3.layer.cornerRadius = 5
                }
                if array[3] != "" {
                    img4View.layer.cornerRadius = 5
                    img4View.layer.borderColor = UIColor.lightGray.cgColor
                    img4View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[3]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image4.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image4.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image4.contentMode = .scaleAspectFill
                    image4.layer.masksToBounds = false
                    image4.clipsToBounds = true
                    image4.layer.borderColor = UIColor.white.cgColor
                    image4.layer.borderWidth = 3
                    image4.layer.cornerRadius = 5
                }
                if array[4] != "" {
                    img5View.layer.cornerRadius = 5
                    img5View.layer.borderColor = UIColor.lightGray.cgColor
                    img5View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[4]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image5.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image5.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image5.contentMode = .scaleAspectFill
                    image5.layer.masksToBounds = false
                    image5.clipsToBounds = true
                    image5.layer.borderColor = UIColor.white.cgColor
                    image5.layer.borderWidth = 3
                    image5.layer.cornerRadius = 5
                }
                if array[5] != "" {
                    img6View.layer.cornerRadius = 5
                    img6View.layer.borderColor = UIColor.lightGray.cgColor
                    img6View.layer.borderWidth = 2
                    
                    imgurl = Common.download + array[5]
//                    let url = URL(string: imgurl)
//                    let data = try? Data(contentsOf: url!)
//                    image6.image = UIImage(data: data!)
                    let url = URL(string: imgurl)
                    image6.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                    image6.contentMode = .scaleAspectFill
                    image6.layer.masksToBounds = false
                    image6.clipsToBounds = true
                    image6.layer.borderColor = UIColor.white.cgColor
                    image6.layer.borderWidth = 3
                    image6.layer.cornerRadius = 5
                }
                
            }
            
            image1View.frame = CGRect.init(x: 0, y: image1_yPos , width: self.image1View.frame.width, height: self.image1View.frame.height)
            add_all_Height += image1View.frame.height
            
            image2_yPos = image1_yPos + image1View.frame.height
            
            image2View.frame = CGRect.init(x: 0, y: image2_yPos , width: self.image2View.frame.width, height: self.image2View.frame.height)
            add_all_Height += image2View.frame.height
            
            editProfileButton_yPos = image2_yPos + image2View.frame.height
            
        }
        
        // add subViews to scrollView --------------------------
        tableView.frame = CGRect.init(x: self.tableView.frame.origin.x, y: addDeal_yPos - 2.0, width: self.tableView.frame.width, height: tableHeight)
        btnAddDeal.frame = CGRect.init(x: btnAddDeal.frame.origin.x, y: addBtn_yPos - 2.0, width: self.btnAddDeal.frame.width, height: self.btnAddDeal.frame.height)
        addImageView.frame = CGRect.init(x: addImageView.frame.origin.x, y: addImage_yPos, width: self.addImageView.frame.width, height: self.addImageView.frame.height)
        
        explainView.frame = CGRect.init(x: explainView.frame.origin.x, y: expView_yPos, width: self.explainView.frame.width, height: explainView_height)
        if Common.businessModel.bars[0].deal.count == 0 {
            add_all_Height += (explainView.frame.height - expLabel.frame.height) / 2
        }
        //        add_all_Height += explainView_height
        
        if progress == 100 {
            
            profileInfoView.isHidden = true
            profileInfoView.frame = CGRect.init(x: 0, y: profileInfo_yPos, width: self.profileInfoView.frame.width, height: 0)
        }
        else {
            
            profileInfoView.frame = CGRect.init(x: 0, y: profileInfo_yPos , width: self.profileInfoView.frame.width, height: self.profileInfoView.frame.height)
            add_all_Height += profileInfoView.frame.height
        }
        
        yourBusinessProfileView.frame = CGRect.init(x: 0, y: yourBusinessProfile_yPos , width: self.yourBusinessProfileView.frame.width, height: self.yourBusinessProfileView.frame.height)
        add_all_Height += yourBusinessProfileView.frame.height
        
        businessNameView.frame = CGRect.init(x: 0, y: businessName_yPos , width: self.businessNameView.frame.width, height: self.businessNameView.frame.height)
        add_all_Height += businessNameView.frame.height
        
        categoryNameView.frame = CGRect.init(x: 0, y: categoryName_yPos , width: self.categoryNameView.frame.width, height: self.categoryNameView.frame.height)
        add_all_Height += categoryNameView.frame.height
        
        addressView.frame = CGRect.init(x: 0, y: address_yPos , width: self.addressView.frame.width, height: heightOfaddressView)
        add_all_Height += heightOfaddressView
        
        address_checkView.frame = CGRect.init(x: 0, y: address_yPos, width: self.address_checkView.frame.width, height: address_checkView.frame.height)
        
        telephoneView.frame = CGRect.init(x: 0, y: telephone_yPos , width: self.telephoneView.frame.width, height: self.telephoneView.frame.height)
        add_all_Height += telephoneView.frame.height
        
        emailView.frame = CGRect.init(x: 0, y: email_yPos , width: self.emailView.frame.width, height: self.emailView.frame.height)
        add_all_Height += emailView.frame.height
        
        line1View.frame = CGRect.init(x: 0, y: line1_yPos , width: self.line1View.frame.width, height: self.line1View.frame.height)
        add_all_Height += line1View.frame.height
        
        descriptionView.frame = CGRect.init(x: 0, y: description_yPos, width: self.descriptionView.frame.width, height: heightOfdescriptionView)
        add_all_Height += heightOfdescriptionView
        
        description_checkView.frame = CGRect.init(x: 0, y: description_yPos, width: self.description_checkView.frame.width, height: description_checkView.frame.height)
        /** csr new add**/
        if Common.businessModel.bars[0].category == "Nightlife" {
            musictypeView.frame = CGRect.init(x: 0, y: musictype_yPos , width: self.musictypeView.frame.width, height: self.musictypeView.frame.height)
            add_all_Height += musictypeView.frame.height
        }
        line2View.frame = CGRect.init(x: 0, y: line2_yPos , width: self.line2View.frame.width, height: self.line2View.frame.height)
        add_all_Height += line2View.frame.height
        
        if ((Common.businessModel.bars[0].openHour?.mon_start != "") ||
            (Common.businessModel.bars[0].openHour?.mon_end != "") ||
            (Common.businessModel.bars[0].openHour?.tue_start != "") ||
            (Common.businessModel.bars[0].openHour?.tue_end != "") ||
            (Common.businessModel.bars[0].openHour?.wed_start != "") ||
            (Common.businessModel.bars[0].openHour?.wed_end != "") ||
            (Common.businessModel.bars[0].openHour?.thur_start != "") ||
            (Common.businessModel.bars[0].openHour?.thur_end != "") ||
            (Common.businessModel.bars[0].openHour?.fri_start != "") ||
            (Common.businessModel.bars[0].openHour?.fri_end != "") ||
            (Common.businessModel.bars[0].openHour?.sat_start != "") ||
            (Common.businessModel.bars[0].openHour?.sat_end != "") ||
            (Common.businessModel.bars[0].openHour?.sun_start != "") ||
            (Common.businessModel.bars[0].openHour?.sun_end != "")) {
            
            open_HoursView.frame = CGRect.init(x: 0, y: open_Hours_yPos , width: self.open_HoursView.frame.width, height: self.open_HoursView.frame.height)
            add_all_Height += open_HoursView.frame.height
            
            labMonday.text = "Monday"
            labTuesday.text = "Tuesday"
            labWednesday.text = "Wednesday"
            labThursday.text = "Thursday"
            labFriday.text = "Friday"
            labSaturday.text = "Saturday"
            labSunday.text = "Sunday"
            
            if ((Common.businessModel.bars[0].openHour?.mon_start != "") ||
                (Common.businessModel.bars[0].openHour?.mon_end != "")) {
                
                if (Common.businessModel.bars[0].openHour?.mon_start == "") {
                    timeMonday.text = "           - " + (Common.businessModel.bars[0].openHour?.mon_end)!
                }
                else {
                    timeMonday.text = (Common.businessModel.bars[0].openHour?.mon_start)! + " - " + (Common.businessModel.bars[0].openHour?.mon_end)!
                }
                
            }
            else {
                timeMonday.text = "Closed"
            }
            if ((Common.businessModel.bars[0].openHour?.tue_start != "") ||
                (Common.businessModel.bars[0].openHour?.tue_end != "")) {
                
                if (Common.businessModel.bars[0].openHour?.tue_start == "") {
                    timeTuesday.text = "           - " + (Common.businessModel.bars[0].openHour?.tue_end)!
                }
                else {
                    timeTuesday.text = (Common.businessModel.bars[0].openHour?.tue_start)! + " - " + (Common.businessModel.bars[0].openHour?.tue_end)!
                }
                
            }
            else {
                timeTuesday.text = "Closed"
            }
            if ((Common.businessModel.bars[0].openHour?.wed_start != "") ||
                (Common.businessModel.bars[0].openHour?.wed_end != "")) {
                
                if (Common.businessModel.bars[0].openHour?.wed_start == "") {
                    timeWednesday.text = "           - " + (Common.businessModel.bars[0].openHour?.wed_end)!
                }
                else {
                    timeWednesday.text = (Common.businessModel.bars[0].openHour?.wed_start)! + " - " + (Common.businessModel.bars[0].openHour?.wed_end)!
                }
                
            }
            else {
                timeWednesday.text = "Closed"
            }
            if ((Common.businessModel.bars[0].openHour?.thur_start != "") ||
                (Common.businessModel.bars[0].openHour?.thur_end != "")) {
                
                if (Common.businessModel.bars[0].openHour?.thur_start == "") {
                    timeThursday.text = "           - " + (Common.businessModel.bars[0].openHour?.thur_end)!
                }
                else {
                    timeThursday.text = (Common.businessModel.bars[0].openHour?.thur_start)! + " - " + (Common.businessModel.bars[0].openHour?.thur_end)!
                }
                
            }
            else {
                timeThursday.text = "Closed"
            }
            if ((Common.businessModel.bars[0].openHour?.fri_start != "") ||
                (Common.businessModel.bars[0].openHour?.fri_end != "")) {
                
                if (Common.businessModel.bars[0].openHour?.fri_start == "") {
                    timeFriday.text = "           - " + (Common.businessModel.bars[0].openHour?.fri_end)!
                }
                else {
                    timeFriday.text = (Common.businessModel.bars[0].openHour?.fri_start)! + " - " + (Common.businessModel.bars[0].openHour?.fri_end)!
                }
                
            }
            else {
                timeFriday.text = "Closed"
            }
            if ((Common.businessModel.bars[0].openHour?.sat_start != "") ||
                (Common.businessModel.bars[0].openHour?.sat_end != "")) {
                
                if (Common.businessModel.bars[0].openHour?.sat_start == "") {
                    timeSaturday.text = "           - " + (Common.businessModel.bars[0].openHour?.sat_end)!
                }
                else {
                    timeSaturday.text = (Common.businessModel.bars[0].openHour?.sat_start)! + " - " + (Common.businessModel.bars[0].openHour?.sat_end)!
                }
                
            }
            else {
                timeSaturday.text = "Closed"
            }
            if ((Common.businessModel.bars[0].openHour?.sun_start != "") ||
                (Common.businessModel.bars[0].openHour?.sun_end != "")) {
                
                if (Common.businessModel.bars[0].openHour?.sun_start == "") {
                    timeSunday.text = "           - " + (Common.businessModel.bars[0].openHour?.sun_end)!
                }
                else {
                    timeSunday.text = (Common.businessModel.bars[0].openHour?.sun_start)! + " - " + (Common.businessModel.bars[0].openHour?.sun_end)!
                }
                
            }
            else {
                timeSunday.text = "Closed"
            }
            
        }
        else {
            
            labTuesday.isHidden = true
            labTuesday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            labWednesday.isHidden = true
            labWednesday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            labThursday.isHidden = true
            labThursday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            labFriday.isHidden = true
            labFriday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            labSaturday.isHidden = true
            labSaturday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            labSunday.isHidden = true
            labSunday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            timeTuesday.isHidden = true
            timeTuesday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            timeWednesday.isHidden = true
            timeWednesday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            timeThursday.isHidden = true
            timeThursday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            timeFriday.isHidden = true
            timeFriday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            timeSaturday.isHidden = true
            timeSaturday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            timeSunday.isHidden = true
            timeSunday.frame = CGRect.init(x: 0, y: open_Hours_yPos + labMonday.frame.height, width: 0, height: 0)
            
            
            imgCheck7.frame = CGRect.init(x: imgCheck7.frame.origin.x, y: (open_HoursView.frame.height - imgCheck7.frame.width*7)/2, width: imgCheck7.frame.width, height: imgCheck7.frame.width*7)
            labMonday.frame = CGRect.init(x: labMonday.frame.origin.x, y: 0, width: labMonday.frame.width, height: open_HoursView.frame.height)
            timeMonday.frame = CGRect.init(x: timeMonday.frame.origin.x, y: 0, width: timeMonday.frame.width, height: open_HoursView.frame.height)
            
            open_HoursView.frame = CGRect.init(x: 0, y: open_Hours_yPos, width: self.open_HoursView.frame.width, height: self.open_HoursView.frame.height/7)
            add_all_Height += self.open_HoursView.frame.height/7
            
        }
        
        line3View.frame = CGRect.init(x: 0, y: line3_yPos , width: self.line3View.frame.width, height: self.line3View.frame.height)
        add_all_Height += line3View.frame.height
        
        imageGalleryView.frame = CGRect.init(x: 0, y: imageGallery_yPos , width: self.imageGalleryView.frame.width, height: self.imageGalleryView.frame.height)
        add_all_Height += imageGalleryView.frame.height
        
        editProfileButtonView.frame = CGRect.init(x: 0, y: editProfileButton_yPos , width: self.editProfileButtonView.frame.width, height: self.editProfileButtonView.frame.height)
        add_all_Height += editProfileButtonView.frame.height
        
        scrollView.contentSize.height = profileInfo_yPos + add_all_Height
        // scrollview for control action
        scrollView.addSubview(dealHeaderLabel)
        scrollView.addSubview(tableView)
        scrollView.addSubview(btnAddDeal)
        scrollView.addSubview(addImageView)
        scrollView.addSubview(explainView)
        scrollView.addSubview(profileInfoView)
        scrollView.addSubview(yourBusinessProfileView)
        scrollView.addSubview(businessNameView)
        scrollView.addSubview(categoryNameView)
        scrollView.addSubview(addressView)
        scrollView.addSubview(address_checkView)
        scrollView.addSubview(telephoneView)
        scrollView.addSubview(emailView)
        scrollView.addSubview(descriptionView)
        scrollView.addSubview(description_checkView)
        scrollView.addSubview(line1View)
        /*2018-01-25 add*/
        if Common.businessModel.bars[0].category == "Nightlife" {
           scrollView.addSubview(musictypeView)
        } 
        scrollView.addSubview(line2View)
        scrollView.addSubview(open_HoursView)
        scrollView.addSubview(line3View)
        scrollView.addSubview(imageGalleryView)
        scrollView.addSubview(image1View)
        scrollView.addSubview(image2View)
        scrollView.addSubview(editProfileButtonView)
        
        // draw circle --------------------------
        let y_start = impressionTitleLabel.frame.origin.y + 45
        let y_end = scrollView.contentSize.height
        let x_circle = scrollView.contentSize.width/2
        let r_circle = CGFloat(500)
        let y_circle = y_start + r_circle
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x_circle,y: y_circle), radius: CGFloat(r_circle), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = MyColor.customCircleFillColor().cgColor
        myView.layer.addSublayer(shapeLayer)
        
        
        
        if DeviceType.IS_IPAD_PRO_9_7 {
            let y_start = impressionTitleLabel.frame.origin.y + 70
            let y_end = scrollView.contentSize.height
            let x_circle = scrollView.contentSize.width/2
            let r_circle = CGFloat(1000)
            let y_circle = y_start + r_circle
            
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: x_circle,y: y_circle), radius: CGFloat(r_circle), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            
            //change the fill color
            shapeLayer.fillColor = MyColor.customCircleFillColor().cgColor
            myView.layer.addSublayer(shapeLayer)
        } else if DeviceType.IS_IPAD_PRO_12_9 {
            let y_start = impressionTitleLabel.frame.origin.y + 70
            let y_end = scrollView.contentSize.height
            let x_circle = scrollView.contentSize.width/2
            let r_circle = CGFloat(1110)
            let y_circle = y_start + r_circle
            
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: x_circle,y: y_circle), radius: CGFloat(r_circle), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            
            //change the fill color
            shapeLayer.fillColor = MyColor.customCircleFillColor().cgColor
            myView.layer.addSublayer(shapeLayer)
        } else {
            let y_start = impressionTitleLabel.frame.origin.y + 45
            let y_end = scrollView.contentSize.height
            let x_circle = scrollView.contentSize.width/2
            let r_circle = CGFloat(500)
            let y_circle = y_start + r_circle
            
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: x_circle,y: y_circle), radius: CGFloat(r_circle), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            
            //change the fill color
            shapeLayer.fillColor = MyColor.customCircleFillColor().cgColor
            myView.layer.addSublayer(shapeLayer)
        }
        
        let testView = UIView(frame : CGRect.init(x:0, y:editProfileButton_yPos, width:myView.frame.width, height:1000))
        testView.backgroundColor = UIColor.white
        myView.addSubview(testView)
        
        //        refreshControl = UIRefreshControl()
        //        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //        refreshControl.addTarget(self, action: Selector("refresh:"), for: UIControlEvents.valueChanged)
        myView.addSubview(refreshControl) // not required when using UITableViewController
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
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        refresh_data()
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func refresh(sender:AnyObject) {
        
    }
    
    @IBAction func btnSignOutClick(_ sender: Any) {
        
        GPPSignIn.sharedInstance().signOut()
        // Shared preference format
        self.defaults.set("", forKey: "user_type")
        self.defaults.set("", forKey: "user_id")
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "SigninView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    
    @IBAction func btnAddDealClick(_ sender: Any) {
        
        Common.dealModel.add_deal_flag = 0 // add deal button
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddDealView")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    @IBAction func btnEditProfileImgClick(_ sender: Any) {
        
        Common.editBarModel.bar_id = Common.businessModel.bars[0].bar_id!;
        Common.editBarModel.business_name = Common.businessModel.bars[0].business_name!;
        Common.editBarModel.category_name = Common.businessModel.bars[0].category!;
        Common.editBarModel.post_code = Common.businessModel.bars[0].post_code!;
        Common.editBarModel.address = Common.businessModel.bars[0].address!;
        Common.editBarModel.lat = Common.businessModel.bars[0].lat!;
        Common.editBarModel.lon = Common.businessModel.bars[0].lon!;
        Common.editBarModel.telephone = Common.businessModel.bars[0].telephone!;
        Common.editBarModel.music_type = Common.businessModel.bars[0].music_type!;
        Common.editBarModel.website = Common.businessModel.bars[0].website!;
        Common.editBarModel.email = Common.businessModel.bars[0].email!;
        Common.editBarModel.description = Common.businessModel.bars[0].description!;
        
        Common.editBarModel.editopenHour?.mon_start = Common.businessModel.bars[0].openHour?.mon_start
        Common.editBarModel.editopenHour?.mon_end = Common.businessModel.bars[0].openHour?.mon_end
        Common.editBarModel.editopenHour?.tue_start = Common.businessModel.bars[0].openHour?.tue_start
        Common.editBarModel.editopenHour?.tue_end = Common.businessModel.bars[0].openHour?.tue_end
        Common.editBarModel.editopenHour?.wed_start = Common.businessModel.bars[0].openHour?.wed_start
        Common.editBarModel.editopenHour?.wed_end = Common.businessModel.bars[0].openHour?.wed_end
        Common.editBarModel.editopenHour?.thur_start = Common.businessModel.bars[0].openHour?.thur_start
        Common.editBarModel.editopenHour?.thur_end = Common.businessModel.bars[0].openHour?.thur_end
        Common.editBarModel.editopenHour?.fri_start = (Common.businessModel.bars[0].openHour?.fri_start)!
        Common.editBarModel.editopenHour?.fri_end = Common.businessModel.bars[0].openHour?.fri_end
        Common.editBarModel.editopenHour?.sat_start = Common.businessModel.bars[0].openHour?.sat_start
        Common.editBarModel.editopenHour?.sat_end = Common.businessModel.bars[0].openHour?.sat_end
        Common.editBarModel.editopenHour?.sun_start = Common.businessModel.bars[0].openHour?.sun_start
        Common.editBarModel.editopenHour?.sun_end = Common.businessModel.bars[0].openHour?.sun_end
        
        Common.editBarModel.galleryModel?.background1 = (Common.businessModel.bars[0].bargallery?.background1)!
        Common.editBarModel.galleryModel?.background2 = (Common.businessModel.bars[0].bargallery?.background2)!
        Common.editBarModel.galleryModel?.background3 = (Common.businessModel.bars[0].bargallery?.background3)!
        Common.editBarModel.galleryModel?.background4 = (Common.businessModel.bars[0].bargallery?.background4)!
        Common.editBarModel.galleryModel?.background5 = (Common.businessModel.bars[0].bargallery?.background5)!
        Common.editBarModel.galleryModel?.background6 = (Common.businessModel.bars[0].bargallery?.background6)!
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditBusinessProfile1")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    
    @IBAction func btnEditMyProfileClick(_ sender: Any) {
        
        Common.editBarModel.bar_id = Common.businessModel.bars[0].bar_id!;
        Common.editBarModel.business_name = Common.businessModel.bars[0].business_name!;
        Common.editBarModel.category_name = Common.businessModel.bars[0].category!;
        Common.editBarModel.post_code = Common.businessModel.bars[0].post_code!;
        Common.editBarModel.address = Common.businessModel.bars[0].address!;
        Common.editBarModel.lat = Common.businessModel.bars[0].lat!;
        Common.editBarModel.lon = Common.businessModel.bars[0].lon!;
        Common.editBarModel.telephone = Common.businessModel.bars[0].telephone!;
        Common.editBarModel.music_type = Common.businessModel.bars[0].music_type!;
        Common.editBarModel.website = Common.businessModel.bars[0].website!;
        Common.editBarModel.email = Common.businessModel.bars[0].email!;
        Common.editBarModel.description = Common.businessModel.bars[0].description!;
        
        Common.editBarModel.editopenHour?.mon_start = Common.businessModel.bars[0].openHour?.mon_start
        Common.editBarModel.editopenHour?.mon_end = Common.businessModel.bars[0].openHour?.mon_end
        Common.editBarModel.editopenHour?.tue_start = Common.businessModel.bars[0].openHour?.tue_start
        Common.editBarModel.editopenHour?.tue_end = Common.businessModel.bars[0].openHour?.tue_end
        Common.editBarModel.editopenHour?.wed_start = Common.businessModel.bars[0].openHour?.wed_start
        Common.editBarModel.editopenHour?.wed_end = Common.businessModel.bars[0].openHour?.wed_end
        Common.editBarModel.editopenHour?.thur_start = Common.businessModel.bars[0].openHour?.thur_start
        Common.editBarModel.editopenHour?.thur_end = Common.businessModel.bars[0].openHour?.thur_end
        Common.editBarModel.editopenHour?.fri_start = (Common.businessModel.bars[0].openHour?.fri_start)!
        Common.editBarModel.editopenHour?.fri_end = (Common.businessModel.bars[0].openHour?.fri_end)!
        Common.editBarModel.editopenHour?.sat_start = Common.businessModel.bars[0].openHour?.sat_start
        Common.editBarModel.editopenHour?.sat_end = Common.businessModel.bars[0].openHour?.sat_end
        Common.editBarModel.editopenHour?.sun_start = Common.businessModel.bars[0].openHour?.sun_start
        Common.editBarModel.editopenHour?.sun_end = Common.businessModel.bars[0].openHour?.sun_end
        
        Common.editBarModel.galleryModel?.background1 = (Common.businessModel.bars[0].bargallery?.background1)!
        Common.editBarModel.galleryModel?.background2 = (Common.businessModel.bars[0].bargallery?.background2)!
        Common.editBarModel.galleryModel?.background3 = (Common.businessModel.bars[0].bargallery?.background3)!
        Common.editBarModel.galleryModel?.background4 = (Common.businessModel.bars[0].bargallery?.background4)!
        Common.editBarModel.galleryModel?.background5 = (Common.businessModel.bars[0].bargallery?.background5)!
        Common.editBarModel.galleryModel?.background6 = (Common.businessModel.bars[0].bargallery?.background6)!
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditBusinessProfile1")
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    // table Action ===============================================================================================
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayOfArray.count
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
    
    // create a cell for each tableview row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get cell of TableView
        cell = DealItemViewCell.instanceFromNib() as! DealItemViewCell
        
        cell?.clipsToBounds = true
        let choice = arrayOfArray[indexPath.section]
        cell?.winkImageView.frame = CGRect.init(x: (cell?.winkImageView.frame.origin.x)!, y: (cell?.winkImageView.frame.origin.y)!, width: Common.imageSize[0].winkImageView_width, height: Common.imageSize[0].winkImageView_height)
        cell?.readImageView.frame = CGRect.init(x: (cell?.readImageView.frame.origin.x)!, y: (cell?.readImageView.frame.origin.y)!, width: Common.imageSize[0].readImageView_width, height: Common.imageSize[0].readImageView_height)
        cell?.walletImageView.frame = CGRect.init(x: (cell?.walletImageView.frame.origin.x)!, y: (cell?.walletImageView.frame.origin.y)!, width: Common.imageSize[0].walletImageView_width, height: Common.imageSize[0].walletImageView_height)
        
        cell?.barTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].deal_name_size))
        cell?.descriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].description_size))
        cell?.day_durationLabel.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        cell?.labImpressionsItem.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        cell?.labEngagementsItem.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        cell?.labClicksItem.font = UIFont.systemFont(ofSize: CGFloat(Common.fontsizeModel[0].small_comment_size))
        cell?.editDealBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(Common.fontsizeModel[0].sub_button_size))
        
        cell?.barTitleLabel.text = choice.title
        cell?.descriptionLabel.text = choice.description
        cell?.day_durationLabel.text = choice.days_duration
        
        cell?.labImpressionsItem.text = choice.impressions
        cell?.labEngagementsItem.text = String(Int(choice.in_wallet)! + Int(Common.businessModel.bars[0].deal[0].engagement!)!)
        cell?.labClicksItem.text = String(Int(choice.claimed)! + Int(Common.businessModel.bars[0].deal[0].clicks!)!)
        
        cell?.editDealBtn.layer.cornerRadius = (cell?.editDealBtn.frame.height)!/2
        cell?.editDealBtn.layer.borderColor = UIColor.white.cgColor
        cell?.layer.cornerRadius = 10
        cell?.editDealBtn.addTarget(self, action: #selector(Select), for: .touchUpInside)
        cell?.btnDeleteDeal.addTarget(self, action: #selector(DeleteDeal), for: .touchUpInside)
        return cell!
    }
    
    //edit deal
    @IBAction func Select(_ sender: Any){
        let superview = (sender as AnyObject).superview
        let cell = superview??.superview as? DealItemViewCell
        
        let indexPath = self.tableView.indexPath(for: cell!)
        let choices = arrayOfArray[(indexPath?.section)!]
        
        // let indexPath = IndexPath(item: 0, section: 0)
        Common.dealModel.add_deal_flag = 1 // edit deal button
        
        Common.businessDash_index = choices.index
        
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddDealView")
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.5
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        //controller
        
    }
    
    //delete deal
    @IBAction func DeleteDeal(_ sender: Any){
        
        let superview = (sender as AnyObject).superview
        let cell = superview??.superview as? DealItemViewCell
        
        let indexPath = self.tableView.indexPath(for: cell!)
        let choices = arrayOfArray[(indexPath?.section)!]
        
        let delete_index = choices.index
        
        Common.inDash_delete_index = delete_index
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "DeleteDealQuestionView")
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
    }
    
    // method to run when tableview cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    // =============================================================================================================
    
    @objc func finishedResponse1() {
        
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        if Common.businessModel.bars[0].deal.count > 0 {
            
            let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessMapView")
            if toViewController != nil {
                //            let transition = CATransition()
                //            transition.type = kCATransitionPush
                //            transition.subtype = kCATransitionFromLeft
                //            transition.duration = 0.5
                //            view.window!.layer.add(transition, forKey: kCATransition)
                //            toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                //            toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                self.activeIndicator.isHidden = true
                self.activeIndicator.stopAnimating()
                self.present(toViewController!, animated: false, completion:nil)
            }
            
        }
        else{
            
            MessageBoxViewController.showAlert(self, title: "Notice", message: "Deal data is is required")
        }
        
        
    }
    @IBAction func BusinessMapViewAction(_ sender: Any) {

        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse1), userInfo: nil, repeats: true)
        self.activeIndicator.isHidden = false
        self.activeIndicator.startAnimating()
        
    }
    
    // refresh module
    // for indicator finish
    @objc func finishedResponse() {
        // timer
        if self.flag == false {
            return
        }
        
        self.view.isUserInteractionEnabled = true
        
        timer.invalidate()
        
        //transition effect
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessDashboardView")
        let transition = CATransition()
        transition.type =  kCATransitionFromBottom
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        view.window!.layer.add(transition, forKey: kCATransition)
        toViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        toViewController?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(toViewController!, animated: true, completion:nil)
        
        
    }
    
    func refresh_data() {
        
        self.flag = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.finishedResponse), userInfo: nil, repeats: true)
        
        let userId = Common.businessModel.user_id
        
        let url = Common.api_location + "refresh_owner.php"
        let params = ["user_id": userId] as [String : Any]
        
        do {
            let opt = try HTTP.POST(url, parameters: params)
            
            self.view.isUserInteractionEnabled = false
            
            
            //get from server
            opt?.run { response in
                if let error = response.error {
                    
                    DispatchQueue.main.sync(execute: {
                        
                        self.view.isUserInteractionEnabled = true
                        
                        MessageBoxViewController.showAlert(self, title: "Error", message: "Server connection is failed")
                        
                        // stop timer
                        self.timer.invalidate()
                        
                        return
                    })
                    
                }
                do {
                    self.decoder = JSONLoader(response.text!)
                                       
                    Common.businessModel = try BusinessModel(JSONLoader(response.text!))
                    if Common.businessModel.success == "true" {
                        self.flag = true
                        
                        //                                self.defaults.set(Common.businessModel.user_type, forKey: "user_type")
                        //                                self.defaults.set(Common.businessModel.user_id, forKey: "user_id")
                        
                    }else {
                        
                        DispatchQueue.main.sync(execute: {
                            
                            self.view.isUserInteractionEnabled = true
                            
                            MessageBoxViewController.showAlert(self, title: "Error", message: Common.businessModel.message!)
                            //                                    MessageBoxViewController.showAlert(self, title: "Error", message: "111")
                            // stop timer
                            self.timer.invalidate()
                            
                            return
                        })
                        
                    }
                    
                } catch {
                    
                    DispatchQueue.main.sync(execute: {
                        
                        self.view.isUserInteractionEnabled = true
                        
                        MessageBoxViewController.showAlert(self, title: "Error", message: Common.businessModel.message!)
                        // MessageBoxViewController.showAlert(self, title: "Error", message: "222")
                        // stop timer
                        self.timer.invalidate()
                        
                        return
                    })
                    
                }
            }
        } catch let error {
            ////Toast.toast("Request error: \(error)")
        }
        
        
    }
    
}

extension UILabel {
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
}

